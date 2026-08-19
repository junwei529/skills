from __future__ import annotations

import argparse
import json
import re
import stat
import subprocess
import sys
from collections.abc import Callable
from pathlib import Path, PurePosixPath
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
DOCUMENTATION_IMPACT_SCHEMA = "documentation-impact-closure/v1"
DOCUMENTATION_IMPACT_DISPOSITIONS = {
    "UPDATE",
    "CHECKED_NO_CHANGE",
    "NOT_APPLICABLE",
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


def check_repository_coordination_contract(failures: list[str]) -> None:
    contracts = (
        (
            "docs/decisions/0025-monorepo-coordination-and-skill-contract-hardening.md",
            "Decision",
            (
                "one Git repository, one saved Codex Project, and one shared release and evaluation envelope",
                "Directory, repository, saved Project, branch, worktree, and task or Session identity are separate dimensions.",
                "A provider owns its public contract.",
                "Dependency grants neither cross-write authority",
                "one checkpoint-bound disposition",
            ),
        ),
        (
            "docs/decisions/0025-monorepo-coordination-and-skill-contract-hardening.md",
            "Non-Goals",
            (
                "no non-Git coordination parent",
                "no per-Skill repository, saved Project, or independent version line",
                "no Plugin, MCP service, controller, broker, generic adapter, lock, receipt database, or host enforcement",
                "no malicious-same-user or host-level security claim",
            ),
        ),
        (
            "docs/decisions/0025-monorepo-coordination-and-skill-contract-hardening.md",
            "Re-evaluation Conditions",
            (
                "Two completed planning or release cycles",
                "At least three independently recorded",
                "across at least two Phases",
                "Directory count, task count, Phase duration, and repository size alone do not meet a trigger.",
            ),
        ),
        (
            "AGENTS.md",
            "Repository Coordination",
            (
                "Directory, repository, saved Project, branch, worktree, and task or Session identity are separate dimensions",
                "exactly one repository writer owns the write window",
                "Dependency grants no cross-write authority",
                "one checkpoint-bound disposition",
            ),
        ),
        (
            "docs/ARCHITECTURE.md",
            "Repository Coordination Topology",
            (
                "one Git repository, one saved Codex Project, and one shared release and evaluation envelope",
                "Several authorized readers may inspect the same committed contract, while one exact repository writer owns the write window.",
                "Compatibility declaration",
                "Assembled integration tests",
            ),
        ),
        (
            "docs/RUNBOOK.md",
            "Repository Coordination",
            (
                "Classify every participant as a reader, active Session, or current writer.",
                "A dependency or failing consumer test is evidence for a delta, not cross-write authority.",
                "one checkpoint-bound disposition",
                "Reconcile every registered worktree status-only",
            ),
        ),
        (
            "docs/PROVENANCE.md",
            "Source Categories",
            (
                "Approved portable repository-coordination requirements",
                "no private repository, prompt, task, path, memory, or session material was inspected or copied",
            ),
        ),
        (
            "docs/INDEX.md",
            "Decisions",
            (
                "0025-monorepo-coordination-and-skill-contract-hardening.md",
                "Monorepo identity binding, one-writer routing, provider/consumer ownership, checkpoint convergence, and measurable split triggers",
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


def check_documentation_impact_closure(
    closure: dict[str, object],
    actual_review_target: set[str],
    failures: list[str],
    *,
    head_paths: set[str] | None = None,
    rename_sources: dict[str, str] | None = None,
) -> None:
    """Validate one declared documentation-impact closure."""

    if head_paths is None:
        head_paths = documentation_impact_head_paths(failures)
    if rename_sources is None:
        rename_sources = documentation_impact_rename_sources(failures)

    expected_top_level = {
        "schema",
        "closure_id",
        "authorized_change_envelope",
        "intended_update_set",
        "review_target",
        "changed_facts",
    }
    actual_top_level = set(closure)
    if actual_top_level != expected_top_level:
        failures.append(
            "documentation-impact closure: top-level fields mismatch; "
            f"missing={sorted(expected_top_level - actual_top_level)}, "
            f"unexpected={sorted(actual_top_level - expected_top_level)}"
        )

    if closure.get("schema") != DOCUMENTATION_IMPACT_SCHEMA:
        failures.append(
            "documentation-impact closure: schema must be "
            f"{DOCUMENTATION_IMPACT_SCHEMA}"
        )
    closure_id = closure.get("closure_id")
    if not isinstance(closure_id, str) or not closure_id.strip():
        failures.append(
            "documentation-impact closure: closure_id must be a non-empty string"
        )

    envelope = documentation_impact_path_set(
        closure.get("authorized_change_envelope"),
        "authorized_change_envelope",
        failures,
    )
    intended_updates = documentation_impact_path_set(
        closure.get("intended_update_set"),
        "intended_update_set",
        failures,
    )
    declared_review_target = documentation_impact_path_set(
        closure.get("review_target"),
        "review_target",
        failures,
    )

    authority_owners = documentation_authority_owners(failures)
    changed_facts = closure.get("changed_facts")
    if not isinstance(changed_facts, list) or not changed_facts:
        failures.append(
            "documentation-impact closure: changed_facts must be a non-empty list"
        )
        changed_facts = []

    update_dispositions: set[str] = set()
    seen_facts: set[str] = set()
    for fact_index, fact_record in enumerate(changed_facts):
        label = f"documentation-impact closure: changed_facts[{fact_index}]"
        if not isinstance(fact_record, dict):
            failures.append(f"{label} must be an object")
            continue

        expected_fact_fields = {
            "fact",
            "fact_class",
            "canonical_owner",
            "bounded_consumers",
            "dispositions",
        }
        fact_fields = set(fact_record)
        if fact_fields != expected_fact_fields:
            failures.append(
                f"{label} fields mismatch; "
                f"missing={sorted(expected_fact_fields - fact_fields)}, "
                f"unexpected={sorted(fact_fields - expected_fact_fields)}"
            )

        fact = fact_record.get("fact")
        if not isinstance(fact, str) or not fact.strip():
            failures.append(f"{label}.fact must be a non-empty string")
        elif fact in seen_facts:
            failures.append(f"{label}.fact is duplicated: {fact}")
        else:
            seen_facts.add(fact)

        fact_class = fact_record.get("fact_class")
        if not isinstance(fact_class, str) or not fact_class.strip():
            failures.append(f"{label}.fact_class must be a non-empty string")
            fact_class = ""
        elif fact_class not in authority_owners:
            failures.append(
                f"{label}.fact_class is not declared in docs/AUTHORITY.md: "
                f"{fact_class}"
            )

        canonical_owner = documentation_impact_path(
            fact_record.get("canonical_owner"),
            f"{label}.canonical_owner",
            failures,
        )
        consumers = documentation_impact_path_set(
            fact_record.get("bounded_consumers"),
            f"{label}.bounded_consumers",
            failures,
        )
        if canonical_owner is not None and canonical_owner in consumers:
            failures.append(
                f"{label}.bounded_consumers repeats canonical owner: "
                f"{canonical_owner}"
            )

        if canonical_owner is not None and fact_class in authority_owners:
            if not authority_owner_matches(
                canonical_owner,
                authority_owners[fact_class],
            ):
                failures.append(
                    f"{label}.canonical_owner does not match docs/AUTHORITY.md "
                    f"for fact class: {canonical_owner}"
                )

        mapped_paths = set(consumers)
        if canonical_owner is not None:
            mapped_paths.add(canonical_owner)

        dispositions = fact_record.get("dispositions")
        if not isinstance(dispositions, list):
            failures.append(f"{label}.dispositions must be a list")
            dispositions = []

        disposition_paths: set[str] = set()
        disposition_statuses: dict[str, str] = {}
        for disposition_index, disposition in enumerate(dispositions):
            disposition_label = (
                f"{label}.dispositions[{disposition_index}]"
            )
            if not isinstance(disposition, dict):
                failures.append(f"{disposition_label} must be an object")
                continue
            expected_disposition_fields = {"path", "status", "reason"}
            disposition_fields = set(disposition)
            if disposition_fields != expected_disposition_fields:
                failures.append(
                    f"{disposition_label} fields mismatch; "
                    f"missing={sorted(expected_disposition_fields - disposition_fields)}, "
                    f"unexpected={sorted(disposition_fields - expected_disposition_fields)}"
                )

            path = documentation_impact_path(
                disposition.get("path"),
                f"{disposition_label}.path",
                failures,
            )
            if path is not None:
                if path in disposition_paths:
                    failures.append(
                        f"{disposition_label}.path is duplicated: {path}"
                    )
                disposition_paths.add(path)

            status = disposition.get("status")
            if status not in DOCUMENTATION_IMPACT_DISPOSITIONS:
                failures.append(
                    f"{disposition_label}.status must be one of "
                    f"{sorted(DOCUMENTATION_IMPACT_DISPOSITIONS)}"
                )
            elif status == "UPDATE" and path is not None:
                update_dispositions.add(path)
            if path is not None and isinstance(status, str):
                disposition_statuses[path] = status

            reason = disposition.get("reason")
            if not isinstance(reason, str) or not reason.strip():
                failures.append(
                    f"{disposition_label}.reason must be a non-empty string"
                )

        for missing_path in sorted(mapped_paths - disposition_paths):
            failures.append(
                f"{label}: missing disposition for bounded consumer: "
                f"{missing_path}"
            )
        for unexpected_path in sorted(disposition_paths - mapped_paths):
            failures.append(
                f"{label}: disposition is not a mapped owner/consumer: "
                f"{unexpected_path}"
            )
        check_documentation_impact_mapped_paths(
            canonical_owner,
            consumers,
            mapped_paths,
            disposition_statuses,
            head_paths,
            rename_sources,
            label,
            failures,
        )

    if not declared_review_target:
        failures.append(
            "documentation-impact closure: review_target must not be empty"
        )
    if intended_updates != update_dispositions:
        failures.append(
            "documentation-impact closure: intended_update_set does not match "
            "UPDATE dispositions; "
            f"missing={sorted(update_dispositions - intended_updates)}, "
            f"unexpected={sorted(intended_updates - update_dispositions)}"
        )
    if declared_review_target != actual_review_target:
        failures.append(
            "documentation-impact closure: declared review_target does not match "
            "the actual uncommitted Git target; "
            f"missing={sorted(actual_review_target - declared_review_target)}, "
            f"unexpected={sorted(declared_review_target - actual_review_target)}"
        )
    if intended_updates != declared_review_target:
        failures.append(
            "documentation-impact closure: actual review target contains an "
            "undeclared or unowned path, or an UPDATE is outside review; "
            f"missing_updates={sorted(declared_review_target - intended_updates)}, "
            f"outside_review={sorted(intended_updates - declared_review_target)}"
        )
    outside_envelope = intended_updates - envelope
    if outside_envelope:
        failures.append(
            "documentation-impact closure: UPDATE path is outside the authorized "
            f"change envelope: {sorted(outside_envelope)}"
        )


def documentation_impact_path(
    value: object,
    label: str,
    failures: list[str],
) -> str | None:
    if not isinstance(value, str) or not value:
        failures.append(f"{label} must be a non-empty repository-relative path")
        return None
    if "\\" in value or value.startswith("/") or re.match(r"^[A-Za-z]:", value):
        failures.append(f"{label} must use a POSIX repository-relative path: {value}")
        return None
    normalized = PurePosixPath(value).as_posix()
    if normalized != value or any(part in (".", "..") for part in PurePosixPath(value).parts):
        failures.append(f"{label} is not a normalized repository-relative path: {value}")
        return None
    return value


def documentation_impact_path_set(
    value: object,
    label: str,
    failures: list[str],
) -> set[str]:
    if not isinstance(value, list):
        failures.append(f"documentation-impact closure: {label} must be a list")
        return set()
    paths: set[str] = set()
    for index, candidate in enumerate(value):
        path = documentation_impact_path(candidate, f"{label}[{index}]", failures)
        if path is None:
            continue
        if path in paths:
            failures.append(
                f"documentation-impact closure: {label} contains duplicate path: "
                f"{path}"
            )
        paths.add(path)
    return paths


def documentation_impact_head_paths(failures: list[str]) -> set[str]:
    completed = subprocess.run(
        ["git", "ls-tree", "-r", "--name-only", "-z", "HEAD", "--"],
        cwd=ROOT,
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="strict",
    )
    if completed.returncode != 0:
        failures.append(
            "documentation-impact closure: could not enumerate HEAD paths; "
            f"git exited {completed.returncode}: {completed.stderr.strip()}"
        )
        return set()
    return {
        path.replace("\\", "/")
        for path in completed.stdout.split("\0")
        if path
    }


def documentation_impact_rename_sources(
    failures: list[str],
) -> dict[str, str]:
    completed = subprocess.run(
        [
            "git",
            "diff",
            "--name-status",
            "-z",
            "--find-renames=50%",
            "--relative",
            "HEAD",
            "--",
        ],
        cwd=ROOT,
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="strict",
    )
    if completed.returncode != 0:
        failures.append(
            "documentation-impact closure: could not resolve rename pairs; "
            f"git exited {completed.returncode}: {completed.stderr.strip()}"
        )
        return {}

    tokens = completed.stdout.split("\0")
    rename_sources: dict[str, str] = {}
    index = 0
    while index < len(tokens) and tokens[index]:
        status = tokens[index]
        index += 1
        path_count = 2 if status.startswith("R") else 1
        if index + path_count > len(tokens):
            failures.append(
                "documentation-impact closure: malformed Git name-status output"
            )
            return {}
        paths = [
            tokens[index + offset].replace("\\", "/")
            for offset in range(path_count)
        ]
        index += path_count
        if status.startswith("R"):
            rename_sources[paths[1]] = paths[0]
    return rename_sources


def check_documentation_impact_mapped_paths(
    canonical_owner: str | None,
    consumers: set[str],
    mapped_paths: set[str],
    disposition_statuses: dict[str, str],
    head_paths: set[str],
    rename_sources: dict[str, str],
    label: str,
    failures: list[str],
    current_file_exists: Callable[[str], bool] | None = None,
) -> None:
    if current_file_exists is None:
        current_file_exists = lambda path: (ROOT / path).is_file()

    if canonical_owner is not None and (
        canonical_owner not in head_paths
        and not current_file_exists(canonical_owner)
    ):
        failures.append(
            f"{label}: canonical owner exists neither at HEAD nor in the "
            f"worktree: {canonical_owner}"
        )

    for consumer in sorted(consumers):
        if consumer in head_paths:
            continue
        rename_source = rename_sources.get(consumer)
        valid_rename = (
            rename_source in mapped_paths
            and disposition_statuses.get(consumer) == "UPDATE"
            and disposition_statuses.get(rename_source) == "UPDATE"
            and current_file_exists(consumer)
        )
        if not valid_rename:
            failures.append(
                f"{label}: bounded consumer did not exist at HEAD and is not a "
                f"mapped UPDATE rename destination: {consumer}"
            )


def existing_git_documentation_impact_record(
    relative_path: str,
    failures: list[str],
    runner: Callable[..., subprocess.CompletedProcess[str]] = subprocess.run,
) -> bool:
    checks = (
        (
            ["git", "ls-files", "--error-unmatch", "--", relative_path],
            "record must be tracked in the index",
        ),
        (
            ["git", "cat-file", "-e", f"HEAD:{relative_path}"],
            "record must already exist at HEAD",
        ),
    )
    for command, requirement in checks:
        completed = runner(
            command,
            cwd=ROOT,
            check=False,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
        if completed.returncode != 0:
            failures.append(
                f"documentation-impact closure: {requirement}: {relative_path}"
            )
            return False
    return True


def tracked_repository_markdown_path(
    relative_path: str,
    failures: list[str],
) -> Path | None:
    path = ROOT / relative_path
    if path.suffix.lower() != ".md":
        failures.append(
            "documentation-impact closure: record must be Markdown: "
            f"{relative_path}"
        )
        return None
    if not path.is_file():
        failures.append(
            "documentation-impact closure: record file does not exist: "
            f"{relative_path}"
        )
        return None

    current = ROOT
    for part in PurePosixPath(relative_path).parts:
        current /= part
        is_junction = getattr(current, "is_junction", None)
        attributes = getattr(current.lstat(), "st_file_attributes", 0)
        reparse_flag = getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0)
        if current.is_symlink() or (
            is_junction is not None and is_junction()
        ) or bool(attributes & reparse_flag):
            failures.append(
                "documentation-impact closure: record path contains a reparse "
                f"point: {relative_path}"
            )
            return None

    try:
        resolved_root = ROOT.resolve(strict=True)
        resolved_path = path.resolve(strict=True)
        resolved_path.relative_to(resolved_root)
    except (OSError, ValueError) as error:
        failures.append(
            "documentation-impact closure: record does not resolve inside the "
            f"repository root: {relative_path}: {error}"
        )
        return None

    if not existing_git_documentation_impact_record(relative_path, failures):
        return None
    return path


def parse_documentation_authority_owners(
    text: str,
    source: str,
    failures: list[str],
) -> dict[str, tuple[str, ...]]:
    authority_section = markdown_section(
        text,
        "Current Fact Ownership",
    )
    if authority_section is None:
        failures.append(
            f"{source}: missing or duplicate Current Fact Ownership section"
        )
        return {}
    owners: dict[str, tuple[str, ...]] = {}
    for line in authority_section.splitlines():
        if not line.startswith("|"):
            continue
        columns = [column.strip() for column in line.split("|")[1:-1]]
        if len(columns) != 2 or columns[0] in ("Fact class", "---"):
            continue
        fact_class, owner_cell = columns
        owner_tokens = tuple(re.findall(r"`([^`]+)`", owner_cell))
        if not owner_tokens:
            failures.append(
                f"{source}: canonical-owner table row has no path token: "
                f"{fact_class}"
            )
            continue
        if fact_class in owners:
            failures.append(
                f"{source}: duplicate fact class in canonical-owner table: "
                f"{fact_class}"
            )
            continue
        owners[fact_class] = owner_tokens
    if not owners:
        failures.append(
            f"{source}: canonical-owner fact-class table was not found"
        )
    return owners


def documentation_authority_owners(
    failures: list[str],
) -> dict[str, tuple[str, ...]]:
    authority_path = ROOT / "docs" / "AUTHORITY.md"
    current_owners = parse_documentation_authority_owners(
        authority_path.read_text(encoding="utf-8"),
        "docs/AUTHORITY.md",
        failures,
    )
    baseline = subprocess.run(
        ["git", "show", "HEAD:docs/AUTHORITY.md"],
        cwd=ROOT,
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="strict",
    )
    if baseline.returncode != 0:
        failures.append(
            "documentation-impact closure: could not read the HEAD Authority "
            f"owner table; git exited {baseline.returncode}: "
            f"{baseline.stderr.strip()}"
        )
        return {}
    baseline_owners = parse_documentation_authority_owners(
        baseline.stdout,
        "HEAD:docs/AUTHORITY.md",
        failures,
    )
    if current_owners != baseline_owners:
        failures.append(
            "documentation-impact closure: canonical fact-class ownership differs "
            "from HEAD; ownership changes require a separate decision"
        )
        return {}
    return current_owners


def authority_owner_matches(owner: str, owner_tokens: tuple[str, ...]) -> bool:
    for token in owner_tokens:
        pattern = re.escape(token).replace(re.escape("<skill-name>"), r"[^/]+")
        if token.endswith("/"):
            pattern += r".+"
        if re.fullmatch(pattern, owner):
            return True
    return False


def rendered_documentation_impact_blocks(
    text: str,
    relative_path: str,
    failures: list[str],
) -> list[str]:
    blocks: list[str] = []
    fence_character: str | None = None
    fence_length = 0
    closure_body: list[str] | None = None
    inside_html_comment = False
    for line in text.splitlines(keepends=True):
        content = line.rstrip("\r\n")
        if fence_character is None:
            opening = None
            if not inside_html_comment:
                opening = re.match(
                    r"^[ ]{0,3}(?P<fence>`{3,}|~{3,})(?P<info>.*)$",
                    content,
                )
            if opening is not None:
                fence = opening.group("fence")
                fence_character = fence[0]
                fence_length = len(fence)
                if opening.group("info").strip() == (
                    "documentation-impact-closure"
                ):
                    closure_body = []
            else:
                cursor = 0
                while cursor < len(content):
                    if inside_html_comment:
                        comment_end = content.find("-->", cursor)
                        if comment_end == -1:
                            break
                        inside_html_comment = False
                        cursor = comment_end + 3
                    else:
                        comment_start = content.find("<!--", cursor)
                        if comment_start == -1:
                            break
                        inside_html_comment = True
                        cursor = comment_start + 4
        else:
            closing = re.match(
                rf"^[ ]{{0,3}}{re.escape(fence_character)}"
                rf"{{{fence_length},}}[ \t]*$",
                content,
            )
            if closing is not None:
                if closure_body is not None:
                    blocks.append("".join(closure_body).rstrip("\r\n"))
                fence_character = None
                fence_length = 0
                closure_body = None
            elif closure_body is not None:
                closure_body.append(line)

    if closure_body is not None:
        failures.append(
            f"{relative_path}: unclosed rendered documentation-impact closure block"
        )
    return blocks


def load_documentation_impact_closure(
    relative_path: str,
    closure_id: str,
    failures: list[str],
) -> dict[str, object] | None:
    normalized_path = documentation_impact_path(
        relative_path,
        "documentation-impact closure record",
        failures,
    )
    if normalized_path is None:
        return None
    path = tracked_repository_markdown_path(normalized_path, failures)
    if path is None:
        return None

    records: list[dict[str, object]] = []
    blocks = rendered_documentation_impact_blocks(
        path.read_text(encoding="utf-8"),
        normalized_path,
        failures,
    )
    for block_index, block in enumerate(blocks):
        try:
            record = json.loads(block)
        except json.JSONDecodeError as error:
            failures.append(
                f"{normalized_path}: documentation-impact closure block "
                f"{block_index + 1} is invalid JSON: {error}"
            )
            continue
        if not isinstance(record, dict):
            failures.append(
                f"{normalized_path}: documentation-impact closure block "
                f"{block_index + 1} must contain a JSON object"
            )
            continue
        records.append(record)

    selected = [record for record in records if record.get("closure_id") == closure_id]
    if len(selected) != 1:
        failures.append(
            f"{normalized_path}: expected exactly one documentation-impact closure "
            f"with closure_id {closure_id!r}; found {len(selected)}"
        )
        return None
    return selected[0]


def git_uncommitted_paths(failures: list[str]) -> set[str]:
    paths: set[str] = set()
    commands = (
        (
            "tracked diff",
            [
                "git",
                "diff",
                "--no-renames",
                "--name-only",
                "-z",
                "--relative",
                "HEAD",
                "--",
            ],
        ),
        (
            "untracked files",
            ["git", "ls-files", "--others", "--exclude-standard", "-z", "--"],
        ),
    )
    for label, command in commands:
        completed = subprocess.run(
            command,
            cwd=ROOT,
            check=False,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
            errors="strict",
        )
        if completed.returncode != 0:
            failures.append(
                f"documentation-impact closure: could not resolve {label}; "
                f"git exited {completed.returncode}: {completed.stderr.strip()}"
            )
            continue
        for path in completed.stdout.split("\0"):
            if path:
                paths.add(path.replace("\\", "/"))
    return paths


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

    hidden_closure_documents = (
        "<!--\n"
        "```documentation-impact-closure\n{}\n```\n"
        "-->\n",
        "````markdown\n"
        "```documentation-impact-closure\n{}\n```\n"
        "````\n",
    )
    for hidden_document in hidden_closure_documents:
        hidden_closure_failures: list[str] = []
        if rendered_documentation_impact_blocks(
            hidden_document,
            "scanner-self-test.md",
            hidden_closure_failures,
        ):
            failures.append(
                "scanner self-test: hidden documentation-impact closure was visible"
            )
        if hidden_closure_failures:
            failures.append(
                "scanner self-test: hidden documentation-impact probe failed: "
                + " | ".join(hidden_closure_failures)
            )
    visible_closure_failures: list[str] = []
    visible_closure_blocks = rendered_documentation_impact_blocks(
        "```documentation-impact-closure\n{}\n```\n",
        "scanner-self-test.md",
        visible_closure_failures,
    )
    if visible_closure_blocks != ["{}"] or visible_closure_failures:
        failures.append(
            "scanner self-test: rendered documentation-impact closure was not found"
        )
    literal_comment_failures: list[str] = []
    literal_comment_blocks = rendered_documentation_impact_blocks(
        "```html\n"
        "<!-- illustrative literal comment\n"
        "```\n"
        "\n"
        "```documentation-impact-closure\n{}\n```\n",
        "scanner-self-test.md",
        literal_comment_failures,
    )
    if literal_comment_blocks != ["{}"] or literal_comment_failures:
        failures.append(
            "scanner self-test: fenced literal HTML comment hid a rendered "
            "documentation-impact closure"
        )

    staged_new_commands: list[list[str]] = []

    def staged_new_runner(
        command: list[str],
        **_: object,
    ) -> subprocess.CompletedProcess[str]:
        staged_new_commands.append(command)
        return subprocess.CompletedProcess(
            command,
            0 if command[1] == "ls-files" else 1,
            "",
            "",
        )

    staged_new_failures: list[str] = []
    if existing_git_documentation_impact_record(
        "docs/staged-new-closure.md",
        staged_new_failures,
        staged_new_runner,
    ):
        failures.append(
            "scanner self-test: staged new documentation-impact record was accepted"
        )
    expected_staged_new_commands = [
        [
            "git",
            "ls-files",
            "--error-unmatch",
            "--",
            "docs/staged-new-closure.md",
        ],
        ["git", "cat-file", "-e", "HEAD:docs/staged-new-closure.md"],
    ]
    if staged_new_commands != expected_staged_new_commands or not any(
        "must already exist at HEAD" in failure
        for failure in staged_new_failures
    ):
        failures.append(
            "scanner self-test: staged new documentation-impact negative did not "
            "exercise the index and HEAD checks"
        )

    omitted_consumer_closure: dict[str, object] = {
        "schema": DOCUMENTATION_IMPACT_SCHEMA,
        "closure_id": "scanner-self-test-omitted-consumer",
        "authorized_change_envelope": [
            "docs/RUNBOOK.md",
            "scripts/check_repository.py",
        ],
        "intended_update_set": [
            "docs/RUNBOOK.md",
            "scripts/check_repository.py",
        ],
        "review_target": [
            "docs/RUNBOOK.md",
            "scripts/check_repository.py",
        ],
        "changed_facts": [
            {
                "fact": "documentation-impact closure procedure",
                "fact_class": (
                    "Development intake, external optimizer experiment, discovery, "
                    "installation, candidate, update, rollback, and release procedure"
                ),
                "canonical_owner": "docs/RUNBOOK.md",
                "bounded_consumers": ["scripts/check_repository.py"],
                "dispositions": [
                    {
                        "path": "docs/RUNBOOK.md",
                        "status": "UPDATE",
                        "reason": "canonical procedure changes",
                    }
                ],
            }
        ],
    }
    omitted_consumer_failures: list[str] = []
    check_documentation_impact_closure(
        omitted_consumer_closure,
        {"docs/RUNBOOK.md", "scripts/check_repository.py"},
        omitted_consumer_failures,
        head_paths={"docs/RUNBOOK.md", "scripts/check_repository.py"},
        rename_sources={},
    )
    if not any(
        "missing disposition" in failure
        for failure in omitted_consumer_failures
    ):
        failures.append(
            "scanner self-test: documentation-impact omission was accepted"
        )

    complete_closure = json.loads(json.dumps(omitted_consumer_closure))
    complete_closure["closure_id"] = "scanner-self-test-complete"
    complete_facts = complete_closure["changed_facts"]
    complete_fact = complete_facts[0]
    complete_fact["dispositions"].append(
        {
            "path": "scripts/check_repository.py",
            "status": "UPDATE",
            "reason": "mechanical consumer changes",
        }
    )
    complete_closure_failures: list[str] = []
    check_documentation_impact_closure(
        complete_closure,
        {"docs/RUNBOOK.md", "scripts/check_repository.py"},
        complete_closure_failures,
        head_paths={"docs/RUNBOOK.md", "scripts/check_repository.py"},
        rename_sources={},
    )
    if complete_closure_failures:
        failures.append(
            "scanner self-test: complete documentation-impact closure failed: "
            + " | ".join(complete_closure_failures)
        )

    mapped_path_failures: list[str] = []
    check_documentation_impact_mapped_paths(
        "docs/RUNBOOK.md",
        {"docs/old-consumer.md", "docs/renamed-consumer.md"},
        {
            "docs/RUNBOOK.md",
            "docs/old-consumer.md",
            "docs/renamed-consumer.md",
        },
        {
            "docs/RUNBOOK.md": "UPDATE",
            "docs/old-consumer.md": "UPDATE",
            "docs/renamed-consumer.md": "UPDATE",
        },
        {"docs/RUNBOOK.md", "docs/old-consumer.md"},
        {"docs/renamed-consumer.md": "docs/old-consumer.md"},
        "scanner self-test",
        mapped_path_failures,
        lambda path: path == "docs/renamed-consumer.md",
    )
    if mapped_path_failures:
        failures.append(
            "scanner self-test: deleted/renamed consumer mapping failed: "
            + " | ".join(mapped_path_failures)
        )

    new_consumer_failures: list[str] = []
    check_documentation_impact_mapped_paths(
        "docs/RUNBOOK.md",
        {"docs/new-consumer.md"},
        {"docs/RUNBOOK.md", "docs/new-consumer.md"},
        {
            "docs/RUNBOOK.md": "UPDATE",
            "docs/new-consumer.md": "UPDATE",
        },
        {"docs/RUNBOOK.md"},
        {},
        "scanner self-test",
        new_consumer_failures,
        lambda _: True,
    )
    if not any(
        "bounded consumer did not exist at HEAD" in failure
        for failure in new_consumer_failures
    ):
        failures.append(
            "scanner self-test: newly added bounded consumer was accepted"
        )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Validate repository structure and optional documentation-impact closure."
    )
    parser.add_argument(
        "--documentation-impact-closure",
        metavar="PATH",
        help=(
            "existing Markdown file containing a fenced "
            "documentation-impact-closure JSON record"
        ),
    )
    parser.add_argument(
        "--documentation-impact-id",
        metavar="ID",
        help="closure_id to select from the documentation-impact record",
    )
    args = parser.parse_args(argv)

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
    check_repository_coordination_contract(failures)
    check_scanner_self_tests(failures)

    closure_requested = args.documentation_impact_closure is not None
    closure_id_requested = args.documentation_impact_id is not None
    if closure_requested != closure_id_requested:
        failures.append(
            "documentation-impact closure: --documentation-impact-closure and "
            "--documentation-impact-id must be provided together"
        )
    elif closure_requested:
        closure = load_documentation_impact_closure(
            args.documentation_impact_closure,
            args.documentation_impact_id,
            failures,
        )
        if closure is not None:
            check_documentation_impact_closure(
                closure,
                git_uncommitted_paths(failures),
                failures,
            )

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

    summary = (
        "Repository check passed: "
        f"{len(files)} text files, {case_count} cases, {fixture_count} fixtures."
    )
    if closure_requested:
        summary += (
            " Documentation-impact closure "
            f"{args.documentation_impact_id!r} matches the uncommitted Git target."
        )
    print(summary)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
