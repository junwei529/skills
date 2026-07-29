from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[1]
EXPECTED_SKILLS = {
    "manage-project-docs",
    "use-powershell-safely",
    "work-charter",
}
EXPECTED_CASES = {
    "cold-resume.md",
    "powershell-boundary.md",
    "project-docs-adopt.md",
    "project-docs-conflict.md",
    "project-docs-continuity.md",
    "project-docs-mature-noop.md",
    "project-docs-safety-boundaries.md",
    "small-task-stays-flat.md",
    "work-charter-midstream.md",
    "work-charter-planner-executor.md",
    "work-charter-standard.md",
}
EXPECTED_FIXTURES = {
    "cold-resume",
    "powershell-boundary",
    "project-docs-adopt",
    "project-docs-conflict",
    "project-docs-continuity",
    "project-docs-mature-noop",
    "project-docs-safety-boundaries",
    "small-task-stays-flat",
    "work-charter-loop",
    "work-charter-standard",
}
EXPECTED_WORK_CHARTER_FILES = {
    "SKILL.md",
    "agents/openai.yaml",
    "assets/work-charter.md",
    "references/coordination-and-recovery.md",
    "references/standard-ope.md",
}
EXCLUDED_PARTS = {".codegraph", ".eval-runs", ".git", "__pycache__"}
BINARY_SUFFIXES = {
    ".7z",
    ".dll",
    ".exe",
    ".gif",
    ".gz",
    ".ico",
    ".jpeg",
    ".jpg",
    ".mp3",
    ".mp4",
    ".pdf",
    ".png",
    ".ttf",
    ".webm",
    ".webp",
    ".woff",
    ".woff2",
    ".zip",
}

LINK_PATTERN = re.compile(r"!?\[[^\]]*]\(([^)\n]+)\)")
SCAFFOLD_MARKERS = (
    "TODO: Add",
    "TODO: Replace",
    "[TODO",
    "Example resource",
)
PUBLICATION_PATTERNS = {
    "absolute Windows path": re.compile(r"(?i)\b[A-Z]:[\\/]"),
    "UNC path": re.compile(
        r"(?i)\\\\[A-Za-z0-9._-]+\\[A-Za-z0-9.$_-]+"
    ),
    "absolute user-home path": re.compile(r"(?i)/(?:home|users)/[^/<\s]+/"),
    "private Codex data path": re.compile(
        r"(?i)\.codex[\\/](?:memories|rollouts|sessions)"
    ),
    "secret-like token": re.compile(
        r"(?i)\b(?:"
        r"gh[pousr]_[A-Za-z0-9]{20,}|"
        r"sk-(?:proj-)?[A-Za-z0-9_-]{16,}"
        r")"
    ),
    "private-key header": re.compile(r"-----BEGIN [A-Z ]*PRIVATE KEY-----"),
    "UUID-like task identifier": re.compile(
        r"\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-"
        r"[0-9a-f]{4}-[0-9a-f]{12}\b",
        re.IGNORECASE,
    ),
}


def text_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        if any(part in EXCLUDED_PARTS for part in path.relative_to(ROOT).parts):
            continue
        if not is_text_candidate(path):
            continue
        files.append(path)
    return sorted(files)


def is_text_candidate(path: Path) -> bool:
    return path.suffix.lower() not in BINARY_SUFFIXES


def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def markdown_heading_slug(heading: str) -> str:
    rendered = re.sub(r"!\[([^\]]*)]\([^)]+\)", r"\1", heading)
    rendered = re.sub(r"\[([^\]]+)]\([^)]+\)", r"\1", rendered)
    rendered = re.sub(r"<[^>]+>", "", rendered)
    rendered = re.sub(r"\\([\\`*_[\]{}()#+\-.!])", r"\1", rendered)
    rendered = rendered.replace("`", "").lower()
    rendered = re.sub(r"[^\w\- ]", "", rendered, flags=re.UNICODE)
    return rendered.replace(" ", "-")


def markdown_heading_anchors(text: str) -> set[str]:
    anchors: set[str] = set()
    occurrences: dict[str, int] = {}
    heading_pattern = re.compile(r"(?m)^[ ]{0,3}#{1,6}[ \t]+(.+?)[ \t]*#*[ \t]*$")

    for match in heading_pattern.finditer(text):
        base = markdown_heading_slug(match.group(1))
        if not base:
            continue
        occurrence = occurrences.get(base, 0)
        anchor = base if occurrence == 0 else f"{base}-{occurrence}"
        occurrences[base] = occurrence + 1
        anchors.add(anchor)

    return anchors


def check_encoding_and_formatting(
    path: Path, raw: bytes, text: str, failures: list[str]
) -> None:
    relative = path.relative_to(ROOT)
    if raw.startswith(b"\xef\xbb\xbf"):
        failures.append(f"{relative}: UTF-8 BOM is not allowed")

    for number, line in enumerate(text.splitlines(), start=1):
        if line.endswith((" ", "\t")):
            failures.append(f"{relative}:{number}: trailing whitespace")


def check_links(path: Path, text: str, failures: list[str]) -> None:
    if path.suffix.lower() != ".md":
        return

    for match in LINK_PATTERN.finditer(text):
        target = match.group(1).strip()
        if target.startswith("<") and target.endswith(">"):
            target = target[1:-1]
        if not target:
            continue
        if re.match(r"^[A-Za-z][A-Za-z0-9+.-]*:", target):
            continue

        target_path, separator, fragment = target.partition("#")
        target_path = unquote(target_path)
        fragment = unquote(fragment)
        resolved = path.resolve() if not target_path else (path.parent / target_path).resolve()
        try:
            resolved.relative_to(ROOT.resolve())
        except ValueError:
            failures.append(
                f"{path.relative_to(ROOT)}:{line_number(text, match.start())}: "
                f"local link leaves repository: {target_path}"
            )
            continue

        if not resolved.exists():
            failures.append(
                f"{path.relative_to(ROOT)}:{line_number(text, match.start())}: "
                f"missing local link target: {target_path}"
            )
            continue

        if separator and fragment and resolved.suffix.lower() == ".md":
            resolved_text = resolved.read_text(encoding="utf-8")
            if fragment not in markdown_heading_anchors(resolved_text):
                failures.append(
                    f"{path.relative_to(ROOT)}:{line_number(text, match.start())}: "
                    f"missing local Markdown fragment: {target}"
                )


def check_scaffolding(path: Path, text: str, failures: list[str]) -> None:
    relative = path.relative_to(ROOT)
    if not relative.parts or relative.parts[0] != "skills":
        return
    if "assets" in relative.parts:
        return

    for marker in SCAFFOLD_MARKERS:
        if marker in text:
            failures.append(f"{relative}: unresolved scaffold marker: {marker}")


def check_publication_safety(path: Path, text: str, failures: list[str]) -> None:
    relative = path.relative_to(ROOT)
    for label, pattern in PUBLICATION_PATTERNS.items():
        match = pattern.search(text)
        if match:
            failures.append(
                f"{relative}:{line_number(text, match.start())}: {label}"
            )


def linked_local_targets(entry: Path, text: str) -> set[Path]:
    rendered_text = re.sub(
        r"```.*?```|<!--.*?-->|`[^`\n]*`",
        "",
        text,
        flags=re.DOTALL,
    )
    targets: set[Path] = set()
    for match in LINK_PATTERN.finditer(rendered_text):
        target = match.group(1).strip()
        if target.startswith("<") and target.endswith(">"):
            target = target[1:-1]
        if not target or target.startswith("#"):
            continue
        if re.match(r"^[A-Za-z][A-Za-z0-9+.-]*:", target):
            continue
        target = unquote(target.split("#", 1)[0])
        targets.add((entry.parent / target).resolve())
    return targets


def check_direct_references(failures: list[str]) -> None:
    skills_root = ROOT / "skills"
    for skill_dir in sorted(path for path in skills_root.iterdir() if path.is_dir()):
        entry = skill_dir / "SKILL.md"
        references = skill_dir / "references"
        if not entry.exists():
            failures.append(
                f"{skill_dir.relative_to(ROOT)}: missing required SKILL.md"
            )
            continue
        if not references.exists():
            continue

        entry_text = entry.read_text(encoding="utf-8")
        linked_targets = linked_local_targets(entry, entry_text)

        for reference in sorted(path for path in references.iterdir() if path.is_file()):
            if reference.resolve() not in linked_targets:
                failures.append(
                    f"{entry.relative_to(ROOT)}: does not directly link "
                    f"references/{reference.name}"
                )


def check_scanner_self_tests(failures: list[str]) -> None:
    backslash = chr(92)
    publication_probes = {
        "absolute Windows path": (
            "D:" + "/" + "private/repository",
            "<D:" + backslash + "private" + backslash + "repository>",
        ),
        "UNC path": (
            backslash * 2
            + "private-host"
            + backslash
            + "share"
            + backslash
            + "file.txt",
        ),
        "absolute user-home path": (
            "/" + "home" + "/example/private/file.txt",
        ),
        "private Codex data path": (
            "." + "codex" + "/memories/private.jsonl",
        ),
        "secret-like token": ("sk-" + "proj-" + "A" * 24,),
        "private-key header": (
            "-----BEGIN " + "PRIVATE KEY-----",
        ),
        "UUID-like task identifier": (
            "-".join(("aaaaaaaa", "bbbb", "7ccc", "8ddd", "eeeeeeeeeeee")),
        ),
    }
    for label, probes in publication_probes.items():
        pattern = PUBLICATION_PATTERNS[label]
        for probe in probes:
            if not pattern.search(probe):
                failures.append(
                    f"scanner self-test: {label} did not match its probe"
                )

    for candidate in ("LICENSE", ".env", "config.toml", "notes.txt"):
        if not is_text_candidate(Path(candidate)):
            failures.append(
                f"scanner self-test: publication text skipped: {candidate}"
            )
    if is_text_candidate(Path("image.png")):
        failures.append("scanner self-test: known binary type treated as text")

    synthetic_entry = ROOT / "synthetic-skill" / "SKILL.md"
    expected_target = (synthetic_entry.parent / "references/example.md").resolve()
    visible = linked_local_targets(
        synthetic_entry,
        "[Example](references/example.md)",
    )
    hidden = linked_local_targets(
        synthetic_entry,
        "references/example.md\n"
        "```\n[Example](references/example.md)\n```\n"
        "<!-- [Example](references/example.md) -->",
    )
    if expected_target not in visible:
        failures.append("scanner self-test: visible Markdown link was not found")
    if expected_target in hidden:
        failures.append(
            "scanner self-test: non-rendered reference counted as a direct link"
        )

    synthetic_anchors = markdown_heading_anchors(
        "# Existing\n"
        "## Repeated Heading\n"
        "## Repeated Heading\n"
        "## 中文 UTF-8\n"
    )
    expected_anchors = {
        "existing",
        "repeated-heading",
        "repeated-heading-1",
        "中文-utf-8",
    }
    if synthetic_anchors != expected_anchors:
        failures.append(
            "scanner self-test: Markdown heading fragments were not normalized"
        )

    missing_fragment_failures: list[str] = []
    check_links(
        ROOT / "scanner-self-test.md",
        "[Missing](README.md#scanner-self-test-missing)",
        missing_fragment_failures,
    )
    if not missing_fragment_failures:
        failures.append(
            "scanner self-test: missing Markdown fragment was not detected"
        )


def main() -> int:
    failures: list[str] = []
    files = text_files()

    for path in files:
        raw = path.read_bytes()
        try:
            text = raw.decode("utf-8", errors="strict")
        except UnicodeDecodeError as error:
            failures.append(f"{path.relative_to(ROOT)}: invalid UTF-8: {error}")
            continue

        check_encoding_and_formatting(path, raw, text, failures)
        check_links(path, text, failures)
        check_scaffolding(path, text, failures)
        check_publication_safety(path, text, failures)

    check_direct_references(failures)
    check_scanner_self_tests(failures)

    skill_names = {
        path.name for path in (ROOT / "skills").iterdir() if path.is_dir()
    }
    if skill_names != EXPECTED_SKILLS:
        failures.append(
            "skills: public Skill set mismatch; "
            f"missing={sorted(EXPECTED_SKILLS - skill_names)}, "
            f"unexpected={sorted(skill_names - EXPECTED_SKILLS)}"
        )

    work_charter_root = ROOT / "skills" / "work-charter"
    work_charter_files = {
        path.relative_to(work_charter_root).as_posix()
        for path in work_charter_root.rglob("*")
        if path.is_file()
    }
    if work_charter_files != EXPECTED_WORK_CHARTER_FILES:
        failures.append(
            "skills/work-charter: package shape mismatch; "
            f"missing={sorted(EXPECTED_WORK_CHARTER_FILES - work_charter_files)}, "
            f"unexpected={sorted(work_charter_files - EXPECTED_WORK_CHARTER_FILES)}"
        )

    case_names = {
        path.name for path in (ROOT / "evals" / "cases").glob("*.md")
    }
    fixture_names = {
        path.name
        for path in (ROOT / "evals" / "fixtures").iterdir()
        if path.is_dir()
    }
    case_count = len(case_names)
    fixture_count = len(fixture_names)
    if case_names != EXPECTED_CASES:
        failures.append(
            "evals/cases: case set mismatch; "
            f"missing={sorted(EXPECTED_CASES - case_names)}, "
            f"unexpected={sorted(case_names - EXPECTED_CASES)}"
        )
    if fixture_names != EXPECTED_FIXTURES:
        failures.append(
            "evals/fixtures: fixture set mismatch; "
            f"missing={sorted(EXPECTED_FIXTURES - fixture_names)}, "
            f"unexpected={sorted(fixture_names - EXPECTED_FIXTURES)}"
        )

    if failures:
        for failure in failures:
            print(f"FAIL: {failure}")
        print(f"Repository check failed with {len(failures)} issue(s).")
        return 1

    print(
        "Repository check passed: "
        f"{len(files)} text files, {case_count} cases, {fixture_count} fixtures."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
