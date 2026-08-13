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
    "work-charter-recovery-integrity.md",
    "work-charter-entry.md",
    "work-charter-selection.md",
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
    "work-charter-entry",
    "work-charter-recovery-integrity",
    "work-charter-standard",
}
EXPECTED_SKILL_FILES = {
    "manage-project-docs": {
        "SKILL.md",
        "agents/openai.yaml",
        "assets/templates/continuity-anchor.md",
        "assets/templates/project-doc-starter.md",
        "references/audit-and-adopt.md",
        "references/maintain-and-recover.md",
    },
    "work-charter": {
        "SKILL.md",
        "agents/openai.yaml",
        "assets/work-charter.md",
        "references/coordination-and-recovery.md",
        "references/standard-ope.md",
    },
    "use-powershell-safely": {
        "SKILL.md",
        "agents/openai.yaml",
        "references/native-process-boundaries.md",
        "references/text-encoding-boundaries.md",
        "references/windows-wsl-boundaries.md",
    },
}
EXPECTED_SKILL_DOC_FILES = {
    "DESIGN.md",
    "README.md",
    "README.zh-CN.md",
    "STATE.md",
    "VERIFICATION.md",
}
EXCLUDED_PARTS = {
    ".code-review-graph",
    ".codegraph",
    ".eval-runs",
    ".git",
    "__pycache__",
}
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


def level_two_headings(text: str) -> list[str]:
    return re.findall(r"(?m)^##[ \t]+(.+?)[ \t]*#*[ \t]*$", text)


def mask_non_rendered_markdown(text: str) -> str:
    masked = list(text)

    def mask_span(start: int, end: int) -> None:
        for offset in range(start, end):
            if masked[offset] not in ("\r", "\n"):
                masked[offset] = " "

    for comment in re.finditer(
        r"<!--(?:.*?-->|.*\Z)",
        text,
        flags=re.DOTALL,
    ):
        mask_span(comment.start(), comment.end())

    masked_comments = "".join(masked)
    fence_character: str | None = None
    fence_length = 0
    offset = 0
    for line in masked_comments.splitlines(keepends=True):
        content = line.rstrip("\r\n")
        if fence_character is None:
            opening = re.match(r"^[ ]{0,3}(?P<fence>`{3,}|~{3,})", content)
            if opening is not None:
                fence = opening.group("fence")
                fence_character = fence[0]
                fence_length = len(fence)
                mask_span(offset, offset + len(line))
        else:
            mask_span(offset, offset + len(line))
            closing = re.match(
                rf"^[ ]{{0,3}}{re.escape(fence_character)}{{{fence_length},}}[ \t]*$",
                content,
            )
            if closing is not None:
                fence_character = None
                fence_length = 0
        offset += len(line)

    return "".join(masked)


def normalize_contract_text(text: str) -> str:
    return re.sub(r"\s+", " ", mask_non_rendered_markdown(text)).strip()


def markdown_section(text: str, heading: str) -> str | None:
    heading_pattern = re.compile(
        r"(?m)^(?P<marks>#{1,6})[ \t]+(?P<title>.+?)[ \t]*#*[ \t]*$"
    )
    matches = list(heading_pattern.finditer(mask_non_rendered_markdown(text)))
    selected = [
        (index, match)
        for index, match in enumerate(matches)
        if match.group("title").strip() == heading
    ]
    if len(selected) != 1:
        return None

    selected_index, selected_match = selected[0]
    level = len(selected_match.group("marks"))
    end = len(text)
    for later in matches[selected_index + 1 :]:
        if len(later.group("marks")) <= level:
            end = later.start()
            break
    return text[selected_match.end() : end]


def require_section_contract(
    relative_path: str,
    heading: str,
    required_fragments: tuple[str, ...],
    failures: list[str],
) -> None:
    path = ROOT / relative_path
    if not path.exists():
        failures.append(f"{relative_path}: missing contract owner")
        return

    section = markdown_section(path.read_text(encoding="utf-8"), heading)
    if section is None:
        failures.append(
            f"{relative_path}: missing or duplicate Markdown section: {heading}"
        )
        return

    normalized_section = normalize_contract_text(section)
    for fragment in required_fragments:
        normalized_fragment = normalize_contract_text(fragment)
        if normalized_fragment not in normalized_section:
            failures.append(
                f"{relative_path}#{markdown_heading_slug(heading)}: "
                f"missing contract fragment: {normalized_fragment}"
            )


def check_evaluation_governance_contract(failures: list[str]) -> None:
    contracts = (
        (
            "AGENTS.md",
            "Verification And Git",
            (
                "At the start of each Campaign, successor, or lesson-promotion round",
                "Never infer such a root from the current directory, sibling enumeration, or `__file__` ancestry or directory depth.",
                "exact composed zero-model DEV feasibility path",
                "A failure-only closeout commit is limited to",
                "across every registered worktree",
            ),
        ),
        (
            "docs/RUNBOOK.md",
            "Declare The Complete Envelope Once",
            (
                "At the start of each Campaign, successor, or lesson-promotion round",
                "reread the current project `AGENTS.md`",
            ),
        ),
        (
            "docs/RUNBOOK.md",
            "Qualification Tranche",
            (
                "Treat every external authority, evidence, predecessor, and task-owned carrier root as an authority-bearing input.",
                "never infer it from the current directory, sibling enumeration, or `__file__` ancestry or directory depth.",
                "exact composed chain as a zero-model DEV feasibility pass",
                "Official qualification starts from the reviewed committed revision.",
            ),
        ),
        (
            "docs/RUNBOOK.md",
            "Closeout And Recovery",
            (
                "A sealed qualification-only or transport-failure carrier is evidence, not a product or implementation review target.",
                "Use the failure-only closeout path only when",
                "at most one post-fix native review",
                "every registered worktree has been enumerated and reconciled",
            ),
        ),
        (
            "evals/README.md",
            "Campaign Evidence Semantics",
            (
                "`PROMOTED` on the first committed revision containing this contract",
                "`DEFERRED`: changing a Work Charter private builder/importer",
                "deterministic closeout-consistency check",
                "One clean checkout or a task-completion message is not sufficient.",
            ),
        ),
        (
            "evals/results/2026-08-12-work-charter-d53-gate2-terminal.md",
            "Disposition",
            (
                "Exact candidate: `UNACCEPTED_AT_GATE_2`",
                "D53 Campaign: `QUALIFICATION_FAILED`",
                "Product disposition: `PRODUCT_UNKNOWN`",
                "Fresh model contexts: 0",
                "Canary, product, and assessor `turn/start`: 0 / 0 / 0",
                "automatic D54: not permitted",
            ),
        ),
        (
            "evals/results/2026-08-12-work-charter-d53-gate2-terminal.md",
            "Lesson Disposition",
            (
                "`DEFERRED`",
                "bind nested predecessor-carrier roots explicitly rather than infer them from directory depth",
                "D53 does not describe this private-builder lesson as fixed.",
            ),
        ),
        (
            "docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md",
            "D53 observed terminal",
            (
                "consumed zero behavior `turn/start`",
                "D53 is therefore sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "The nested predecessor-root lesson is `DEFERRED`",
                "No retry, replay, rescore, automatic D54",
            ),
        ),
        (
            "docs/skills/work-charter/STATE.md",
            "Next Gate",
            (
                "D53 is `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "The nested-path builder lesson is `DEFERRED`",
                "No repair, retry, operator recovery, replay, rescore, or automatic D54 is authorized.",
            ),
        ),
        (
            "docs/STATUS.md",
            "Next Gate",
            (
                "D53 is `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "zero model contexts",
                "automatic D54 changes remain excluded",
                "One clean checkout is not writer proof",
            ),
        ),
        (
            "docs/HANDOFF.md",
            "Snapshot",
            (
                "D53 is sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "model contexts and `turn/start` remain zero",
                "no automatic D54 follows",
                "one clean checkout is never writer proof",
            ),
        ),
        (
            "docs/HANDOFF.md",
            "Immediate Next Action",
            (
                "Do not repair or rerun D53",
                "The only next Work Charter product choice",
                "no D54 follows from this closeout.",
            ),
        ),
        (
            "docs/skills/work-charter/STATE.md",
            "Current Writer",
            (
                "`post-D53-factual-reconciliation@main/8e658f18`",
                "every registered worktree",
                "One clean checkout never proves writer relinquishment.",
            ),
        ),
        (
            "docs/VERIFICATION.md",
            "2026-08-12 — Work Charter D53 tracked authorization lifecycle",
            (
                "D53 is sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "zero model contexts and zero `turn/start` were consumed",
                "candidate `c481005...` remains unaccepted",
            ),
        ),
        (
            "docs/skills/work-charter/VERIFICATION.md",
            "2026-08-12 — D53 authorization lifecycle and terminal",
            (
                "D53 is sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`",
                "model context, and `turn/start` did not start",
                "automatic D54 follows",
            ),
        ),
    )
    for relative_path, heading, required_fragments in contracts:
        require_section_contract(
            relative_path,
            heading,
            required_fragments,
            failures,
        )


def check_federated_documentation(failures: list[str]) -> None:
    docs_root = ROOT / "docs" / "skills"
    skill_doc_names = {
        path.name for path in docs_root.iterdir() if path.is_dir()
    }
    if skill_doc_names != EXPECTED_SKILLS:
        failures.append(
            "docs/skills: Skill documentation set mismatch; "
            f"missing={sorted(EXPECTED_SKILLS - skill_doc_names)}, "
            f"unexpected={sorted(skill_doc_names - EXPECTED_SKILLS)}"
        )

    index = ROOT / "docs" / "INDEX.md"
    index_targets = linked_local_targets(
        index, index.read_text(encoding="utf-8")
    )

    readme_pairs = [(ROOT / "README.md", ROOT / "README.zh-CN.md")]
    for skill_name in sorted(EXPECTED_SKILLS):
        skill_docs = docs_root / skill_name
        actual_files = {
            path.relative_to(skill_docs).as_posix()
            for path in skill_docs.rglob("*")
            if path.is_file()
        }
        if actual_files != EXPECTED_SKILL_DOC_FILES:
            failures.append(
                f"docs/skills/{skill_name}: documentation shape mismatch; "
                f"missing={sorted(EXPECTED_SKILL_DOC_FILES - actual_files)}, "
                f"unexpected={sorted(actual_files - EXPECTED_SKILL_DOC_FILES)}"
            )

        for name in sorted(EXPECTED_SKILL_DOC_FILES):
            expected = (skill_docs / name).resolve()
            if expected not in index_targets:
                failures.append(
                    f"docs/INDEX.md: does not link docs/skills/{skill_name}/{name}"
                )

        readme_pairs.append(
            (skill_docs / "README.md", skill_docs / "README.zh-CN.md")
        )

    for english, chinese in readme_pairs:
        if not english.exists() or not chinese.exists():
            failures.append(
                f"{english.relative_to(ROOT)}: missing English/Chinese README pair"
            )
            continue
        english_text = english.read_text(encoding="utf-8")
        chinese_text = chinese.read_text(encoding="utf-8")
        if chinese.resolve() not in linked_local_targets(english, english_text):
            failures.append(
                f"{english.relative_to(ROOT)}: does not link its Chinese mirror"
            )
        if english.resolve() not in linked_local_targets(chinese, chinese_text):
            failures.append(
                f"{chinese.relative_to(ROOT)}: does not link its English canonical"
            )

        english_sections = level_two_headings(english_text)
        chinese_sections = level_two_headings(chinese_text)
        if len(english_sections) != len(chinese_sections):
            failures.append(
                f"{english.relative_to(ROOT)} and {chinese.relative_to(ROOT)}: "
                "top-level public section counts differ"
            )

    forbidden_package_names = {
        "changelog.md",
        "install.md",
        "installation.md",
        "readme.md",
    }
    for skill_name in sorted(EXPECTED_SKILLS):
        package = ROOT / "skills" / skill_name
        for path in package.rglob("*"):
            if path.is_file() and path.name.lower() in forbidden_package_names:
                failures.append(
                    f"{path.relative_to(ROOT)}: repository documentation "
                    "must not be placed inside an installable Skill"
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

    synthetic_section = markdown_section(
        "# Root\n"
        "## Target\n"
        "first line\n"
        "### Nested\n"
        "second line\n"
        "## Next\n"
        "excluded line\n",
        "Target",
    )
    if synthetic_section is None or normalize_contract_text(synthetic_section) != (
        "first line ### Nested second line"
    ):
        failures.append(
            "scanner self-test: Markdown contract section was not bounded"
        )
    if markdown_section("## Duplicate\na\n## Duplicate\nb\n", "Duplicate") is not None:
        failures.append(
            "scanner self-test: duplicate Markdown contract section was accepted"
        )
    fenced_section = markdown_section(
        "# Root\n"
        "## Target\n"
        "visible before\n"
        "````markdown\n"
        "## Target\n"
        "## Next\n"
        "```\n"
        "````\n"
        "<!-- ## Target -->\n"
        "visible after\n"
        "## Next\n"
        "excluded line\n",
        "Target",
    )
    if fenced_section is None or normalize_contract_text(fenced_section) != (
        "visible before visible after"
    ):
        failures.append(
            "scanner self-test: fenced or commented heading changed section bounds"
        )
    hidden_contract_text = normalize_contract_text(
        "visible\n<!-- hidden contract -->\n```text\nhidden fenced contract\n```\n"
    )
    if "hidden contract" in hidden_contract_text:
        failures.append(
            "scanner self-test: non-rendered Markdown satisfied a contract"
        )
    unclosed_comment_text = "visible\n<!-- unclosed\n## Hidden\nhidden contract\n"
    if normalize_contract_text(unclosed_comment_text) != "visible":
        failures.append(
            "scanner self-test: unterminated HTML comment content was visible"
        )
    if markdown_section(unclosed_comment_text, "Hidden") is not None:
        failures.append(
            "scanner self-test: heading inside unterminated comment was visible"
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
    check_federated_documentation(failures)
    check_evaluation_governance_contract(failures)
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

    for skill_name, expected_files in EXPECTED_SKILL_FILES.items():
        skill_root = ROOT / "skills" / skill_name
        actual_files = {
            path.relative_to(skill_root).as_posix()
            for path in skill_root.rglob("*")
            if path.is_file()
        }
        if actual_files != expected_files:
            failures.append(
                f"skills/{skill_name}: package shape mismatch; "
                f"missing={sorted(expected_files - actual_files)}, "
                f"unexpected={sorted(actual_files - expected_files)}"
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
