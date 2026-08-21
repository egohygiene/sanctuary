#!/usr/bin/env python3
"""Validate Sanctuary incubation manifests and the repository index."""

from __future__ import annotations

import argparse
import datetime as dt
import json
import re
import sys
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
INCUBATIONS = ROOT / "incubations"
INDEX = INCUBATIONS / "index.json"
EXAMPLE = ROOT / "examples" / "minimal" / "incubation.json"

SCHEMA_VERSION = "sanctuary.incubation/v1"
INDEX_VERSION = "sanctuary.index/v1"
STATES = {"intake", "exploring", "graduating", "graduated", "archived", "rejected"}
DECISIONS = {"pending", "proposed", "approved", "rejected"}
ID_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
LOGIN_PATTERN = re.compile(r"^[A-Za-z0-9](?:[A-Za-z0-9-]{0,37}[A-Za-z0-9])?$")
REPOSITORY_PATTERN = re.compile(r"^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$")
REQUIRED_FIELDS = {
    "schema_version",
    "id",
    "title",
    "summary",
    "state",
    "question",
    "owner",
    "reviewers",
    "data_classification",
    "sources",
    "candidate_destinations",
    "exit_criteria",
    "baseline_exceptions",
    "decision",
    "created_at",
    "updated_at",
}
SOURCE_FIELDS = {"kind", "url", "revision", "license", "attribution", "recorded_at"}
EXCEPTION_FIELDS = {"rule", "rationale", "approved_by", "expires_at"}
DECISION_FIELDS = {"status", "issue", "destination", "decided_at", "rationale"}


def load_json(path: Path) -> tuple[dict[str, Any] | None, list[str]]:
    """Load an object from *path* and return errors without raising."""

    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        return None, [f"{path.relative_to(ROOT)}: file is missing"]
    except json.JSONDecodeError as error:
        return None, [f"{path.relative_to(ROOT)}:{error.lineno}:{error.colno}: {error.msg}"]
    if not isinstance(value, dict):
        return None, [f"{path.relative_to(ROOT)}: root must be an object"]
    return value, []


def non_empty_string(value: Any) -> bool:
    """Return whether *value* is a non-empty string."""

    return isinstance(value, str) and bool(value.strip())


def valid_date(value: Any) -> bool:
    """Return whether *value* is an ISO 8601 calendar date."""

    if not isinstance(value, str):
        return False
    try:
        dt.date.fromisoformat(value)
    except ValueError:
        return False
    return True


def validate_exact_fields(value: dict[str, Any], expected: set[str], location: str) -> list[str]:
    """Validate required and unknown object fields."""

    errors = [f"{location}: missing field {field!r}" for field in sorted(expected - value.keys())]
    errors.extend(f"{location}: unknown field {field!r}" for field in sorted(value.keys() - expected))
    return errors


def validate_string_list(value: Any, location: str, *, pattern: re.Pattern[str] | None = None) -> list[str]:
    """Validate a non-empty list of unique non-empty strings."""

    if not isinstance(value, list) or not value:
        return [f"{location}: must be a non-empty array"]
    errors: list[str] = []
    seen: set[str] = set()
    for index, item in enumerate(value):
        item_location = f"{location}[{index}]"
        if not non_empty_string(item):
            errors.append(f"{item_location}: must be a non-empty string")
            continue
        if pattern and not pattern.fullmatch(item):
            errors.append(f"{item_location}: has an invalid format")
        if item in seen:
            errors.append(f"{item_location}: duplicates {item!r}")
        seen.add(item)
    return errors


def validate_source(source: Any, location: str) -> list[str]:
    """Validate one provenance source record."""

    if not isinstance(source, dict):
        return [f"{location}: must be an object"]
    errors = validate_exact_fields(source, SOURCE_FIELDS, location)
    kind = source.get("kind")
    if kind not in {"original", "import"}:
        errors.append(f"{location}.kind: must be 'original' or 'import'")
    for field in ("license", "attribution"):
        if not non_empty_string(source.get(field)):
            errors.append(f"{location}.{field}: must be a non-empty string")
    if not valid_date(source.get("recorded_at")):
        errors.append(f"{location}.recorded_at: must be an ISO 8601 date")
    url = source.get("url")
    revision = source.get("revision")
    if url is not None and not non_empty_string(url):
        errors.append(f"{location}.url: must be null or a non-empty string")
    if revision is not None and not non_empty_string(revision):
        errors.append(f"{location}.revision: must be null or a non-empty string")
    if kind == "import":
        if not non_empty_string(url):
            errors.append(f"{location}.url: imported source requires a URL")
    return errors


def validate_exception(exception: Any, location: str) -> list[str]:
    """Validate one time-bounded baseline exception."""

    if not isinstance(exception, dict):
        return [f"{location}: must be an object"]
    errors = validate_exact_fields(exception, EXCEPTION_FIELDS, location)
    for field in ("rule", "rationale"):
        if not non_empty_string(exception.get(field)):
            errors.append(f"{location}.{field}: must be a non-empty string")
    approved_by = exception.get("approved_by")
    if not isinstance(approved_by, str) or not LOGIN_PATTERN.fullmatch(approved_by):
        errors.append(f"{location}.approved_by: must be a GitHub login")
    if not valid_date(exception.get("expires_at")):
        errors.append(f"{location}.expires_at: must be an ISO 8601 date")
    return errors


def validate_decision(decision: Any, state: Any, location: str) -> list[str]:
    """Validate state-specific decision evidence."""

    if not isinstance(decision, dict):
        return [f"{location}: must be an object"]
    errors = validate_exact_fields(decision, DECISION_FIELDS, location)
    status = decision.get("status")
    if status not in DECISIONS:
        errors.append(f"{location}.status: must be one of {sorted(DECISIONS)}")
    for field in ("issue", "destination", "decided_at", "rationale"):
        value = decision.get(field)
        if value is not None and not non_empty_string(value):
            errors.append(f"{location}.{field}: must be null or a non-empty string")
    destination = decision.get("destination")
    if destination is not None and not REPOSITORY_PATTERN.fullmatch(destination):
        errors.append(f"{location}.destination: must use owner/repository form")
    decided_at = decision.get("decided_at")
    if decided_at is not None and not valid_date(decided_at):
        errors.append(f"{location}.decided_at: must be null or an ISO 8601 date")

    if state in {"intake", "exploring"} and status != "pending":
        errors.append(f"{location}.status: {state!r} state requires 'pending'")
    if state == "graduating":
        if status != "proposed":
            errors.append(f"{location}.status: 'graduating' state requires 'proposed'")
        for field in ("issue", "destination", "rationale"):
            if not non_empty_string(decision.get(field)):
                errors.append(f"{location}.{field}: graduating work requires this field")
    if state == "graduated":
        if status != "approved":
            errors.append(f"{location}.status: 'graduated' state requires 'approved'")
        for field in ("issue", "destination", "decided_at", "rationale"):
            if not non_empty_string(decision.get(field)):
                errors.append(f"{location}.{field}: graduated work requires this field")
    if state in {"archived", "rejected"}:
        expected = "rejected" if state == "rejected" else "approved"
        if status != expected:
            errors.append(f"{location}.status: {state!r} state requires {expected!r}")
        for field in ("issue", "decided_at", "rationale"):
            if not non_empty_string(decision.get(field)):
                errors.append(f"{location}.{field}: terminal work requires this field")
    return errors


def validate_manifest(manifest: dict[str, Any], location: str, *, expected_id: str | None = None) -> list[str]:
    """Validate one incubation manifest."""

    errors = validate_exact_fields(manifest, REQUIRED_FIELDS, location)
    if manifest.get("schema_version") != SCHEMA_VERSION:
        errors.append(f"{location}.schema_version: must be {SCHEMA_VERSION!r}")
    incubation_id = manifest.get("id")
    if not isinstance(incubation_id, str) or not ID_PATTERN.fullmatch(incubation_id):
        errors.append(f"{location}.id: must be a lowercase kebab-case identifier")
    elif expected_id is not None and incubation_id != expected_id:
        errors.append(f"{location}.id: must match directory {expected_id!r}")
    for field in ("title", "summary", "question"):
        if not non_empty_string(manifest.get(field)):
            errors.append(f"{location}.{field}: must be a non-empty string")
    state = manifest.get("state")
    if state not in STATES:
        errors.append(f"{location}.state: must be one of {sorted(STATES)}")
    owner = manifest.get("owner")
    if not isinstance(owner, str) or not LOGIN_PATTERN.fullmatch(owner):
        errors.append(f"{location}.owner: must be a GitHub login")
    errors.extend(validate_string_list(manifest.get("reviewers"), f"{location}.reviewers", pattern=LOGIN_PATTERN))
    if manifest.get("data_classification") != "public":
        errors.append(f"{location}.data_classification: Sanctuary accepts only 'public'")

    sources = manifest.get("sources")
    if not isinstance(sources, list) or not sources:
        errors.append(f"{location}.sources: must be a non-empty array")
    else:
        for index, source in enumerate(sources):
            errors.extend(validate_source(source, f"{location}.sources[{index}]"))
    errors.extend(
        validate_string_list(
            manifest.get("candidate_destinations"),
            f"{location}.candidate_destinations",
            pattern=REPOSITORY_PATTERN,
        )
    )
    errors.extend(validate_string_list(manifest.get("exit_criteria"), f"{location}.exit_criteria"))

    exceptions = manifest.get("baseline_exceptions")
    if not isinstance(exceptions, list):
        errors.append(f"{location}.baseline_exceptions: must be an array")
    else:
        for index, exception in enumerate(exceptions):
            errors.extend(validate_exception(exception, f"{location}.baseline_exceptions[{index}]"))
    errors.extend(validate_decision(manifest.get("decision"), state, f"{location}.decision"))

    created = manifest.get("created_at")
    updated = manifest.get("updated_at")
    if not valid_date(created):
        errors.append(f"{location}.created_at: must be an ISO 8601 date")
    if not valid_date(updated):
        errors.append(f"{location}.updated_at: must be an ISO 8601 date")
    if valid_date(created) and valid_date(updated) and updated < created:
        errors.append(f"{location}.updated_at: must not precede created_at")
    return errors


def manifest_summary(manifest: dict[str, Any], path: Path) -> dict[str, Any]:
    """Build the canonical index entry for *manifest*."""

    return {
        "id": manifest.get("id"),
        "title": manifest.get("title"),
        "state": manifest.get("state"),
        "owner": manifest.get("owner"),
        "path": path.parent.relative_to(ROOT).as_posix(),
        "candidate_destinations": manifest.get("candidate_destinations"),
        "updated_at": manifest.get("updated_at"),
    }


def validate_repository(*, include_examples: bool = False) -> list[str]:
    """Validate every incubation and its index projection."""

    errors: list[str] = []
    index, index_errors = load_json(INDEX)
    errors.extend(index_errors)
    manifests: list[tuple[Path, dict[str, Any]]] = []
    for path in sorted(INCUBATIONS.glob("*/incubation.json")):
        manifest, load_errors = load_json(path)
        errors.extend(load_errors)
        if manifest is not None:
            errors.extend(
                validate_manifest(
                    manifest,
                    path.relative_to(ROOT).as_posix(),
                    expected_id=path.parent.name,
                )
            )
            manifests.append((path, manifest))

    if include_examples:
        example, example_errors = load_json(EXAMPLE)
        errors.extend(example_errors)
        if example is not None:
            errors.extend(validate_manifest(example, EXAMPLE.relative_to(ROOT).as_posix()))

    if index is None:
        return errors
    expected_index_fields = {"schema_version", "repository", "incubations"}
    errors.extend(validate_exact_fields(index, expected_index_fields, "incubations/index.json"))
    if index.get("schema_version") != INDEX_VERSION:
        errors.append(f"incubations/index.json.schema_version: must be {INDEX_VERSION!r}")
    if index.get("repository") != "egohygiene/sanctuary":
        errors.append("incubations/index.json.repository: must be 'egohygiene/sanctuary'")

    entries = index.get("incubations")
    if not isinstance(entries, list):
        errors.append("incubations/index.json.incubations: must be an array")
        return errors
    ids = [entry.get("id") for entry in entries if isinstance(entry, dict)]
    if ids != sorted(ids):
        errors.append("incubations/index.json.incubations: entries must be sorted by id")
    if len(ids) != len(set(ids)):
        errors.append("incubations/index.json.incubations: ids must be unique")

    expected = [manifest_summary(manifest, path) for path, manifest in manifests]
    expected.sort(key=lambda entry: str(entry["id"]))
    if entries != expected:
        errors.append("incubations/index.json.incubations: entries do not match manifests")
    return errors


def parse_args() -> argparse.Namespace:
    """Parse command-line arguments."""

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--include-examples",
        action="store_true",
        help="validate the checked-in example manifest too",
    )
    return parser.parse_args()


def main() -> int:
    """Run validation and return a process status."""

    args = parse_args()
    errors = validate_repository(include_examples=args.include_examples)
    if errors:
        for error in errors:
            print(f"error: {error}", file=sys.stderr)
        return 1
    manifest_count = len(list(INCUBATIONS.glob("*/incubation.json")))
    print(f"Sanctuary incubation contract valid: {manifest_count} registered incubations")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
