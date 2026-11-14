"""Validate public metadata for legacy intake; never import or retire source."""
from __future__ import annotations

import re
from typing import Any
from urllib.parse import urlsplit

VERSION = "sanctuary.legacy-intake/v1"
TERMINAL = {"graduated", "archived", "rejected"}
DISPOSITIONS = TERMINAL | {"candidate", "graduation-proposed", "archive-proposed", "quarantine"}
FIELDS = {"id", "source_repository", "source_revision", "revision_unavailable_reason", "source_path",
          "sha256", "checksum_unavailable_reason", "license", "license_state", "attribution",
          "purpose", "version_group", "copied", "disposition", "destination", "decision_reference", "rationale"}


def relative_path(value: Any) -> bool:
    return (isinstance(value, str) and bool(value) and "\\" not in value
            and not re.match(r"^[A-Za-z]:", value)
            and all(part not in {"", ".", ".."} for part in value.split("/")))


def public_url(value: Any) -> bool:
    if not isinstance(value, str):
        return False
    parsed = urlsplit(value)
    return (parsed.scheme == "https" and bool(parsed.hostname) and parsed.username is None
            and parsed.password is None and not parsed.query and not parsed.fragment
            and not any(ord(c) < 32 for c in value))


def validate_legacy_intake(value: Any, *, incubation_id: str | None = None) -> list[str]:
    """Check accounting and source/decision claims, not their external truth.

    Rejected metadata is never echoed: it could contain private paths or names.
    Private items have only an aggregate excluded count, never source records.
    """
    errors: list[str] = []
    def check(ok: bool, code: str) -> None:
        if not ok:
            errors.append(code)
    keys = {"schema_version", "incubation_id", "synthetic", "inventory_complete",
            "expected_public_item_count", "excluded_private_count", "items"}
    if not isinstance(value, dict) or set(value) != keys:
        return ["legacy-intake: incompatible root fields"]
    check(value["schema_version"] == VERSION, "legacy-intake: unsupported version")
    check(isinstance(value["incubation_id"], str) and bool(re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", value["incubation_id"])), "legacy-intake: invalid incubation identity")
    if incubation_id is not None:
        check(value["incubation_id"] == incubation_id, "legacy-intake: incubation identity mismatch")
    for flag in ("synthetic", "inventory_complete"):
        check(type(value[flag]) is bool, "legacy-intake: invalid inventory flag")
    for count in ("expected_public_item_count", "excluded_private_count"):
        check(type(value[count]) is int and value[count] >= 0, "legacy-intake: invalid count")
    items = value["items"]
    if not isinstance(items, list) or len(items) > 4096:
        return errors + ["legacy-intake: invalid item array"]
    check(len(items) == value["expected_public_item_count"], "legacy-intake: incomplete item accounting")
    identities, sources = set(), set()
    for item in items:
        if not isinstance(item, dict) or set(item) != FIELDS:
            errors.append("legacy-intake: incompatible item fields")
            continue
        identifier = item["id"]
        if not isinstance(identifier, str) or not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", identifier):
            errors.append("legacy-intake: invalid item identity")
        else:
            check(identifier not in identities, "legacy-intake: duplicate item identity")
            identities.add(identifier)
        check(public_url(item["source_repository"]), "legacy-intake: source must be a public credential-free HTTPS reference")
        check(relative_path(item["source_path"]), "legacy-intake: invalid source path")
        revision = item["source_revision"]
        checksum = item["sha256"]
        for observed, reason, pattern in ((revision, item["revision_unavailable_reason"], r"[0-9a-f]{40}"),
                                          (checksum, item["checksum_unavailable_reason"], r"[0-9a-f]{64}")):
            check((isinstance(observed, str) and bool(re.fullmatch(pattern, observed)) and reason is None)
                  or (observed is None and isinstance(reason, str) and bool(reason.strip())),
                  "legacy-intake: identity evidence requires an exact hash or explicit unavailable reason")
        source_key = (item["source_repository"], revision, item["source_path"])
        if all(isinstance(v, (str, type(None))) for v in source_key):
            check(source_key not in sources, "legacy-intake: duplicate source identity")
            sources.add(source_key)
        for field in ("attribution", "purpose", "version_group", "rationale"):
            check(isinstance(item[field], str) and bool(item[field].strip()), "legacy-intake: required source/decision context missing")
        state = item["license_state"]
        if not isinstance(state, str):
            state = ""
        check(state in {"verified", "asserted", "unknown", "restricted", "prohibited"}, "legacy-intake: invalid license state")
        check(item["license"] is None or (isinstance(item["license"], str) and bool(item["license"].strip())), "legacy-intake: invalid license identifier")
        check(type(item["copied"]) is bool, "legacy-intake: invalid copied flag")
        if item["copied"]:
            check(state == "verified" and item["license"] is not None and checksum is not None,
                  "legacy-intake: copying requires verified rights and checksum evidence")
        disposition = item["disposition"]
        if not isinstance(disposition, str):
            disposition = ""
        check(disposition in DISPOSITIONS, "legacy-intake: invalid disposition")
        destination = item["destination"]
        check(destination is None or (isinstance(destination, str) and bool(re.fullmatch(r"egohygiene/[a-z0-9][a-z0-9.-]*", destination))), "legacy-intake: invalid candidate destination")
        decision = item["decision_reference"]
        check(decision is None or public_url(decision), "legacy-intake: invalid decision reference")
        if disposition in TERMINAL or disposition in {"graduation-proposed", "archive-proposed"}:
            check(decision is not None, "legacy-intake: disposition requires a separate review reference")
        if disposition in {"graduated", "graduation-proposed"}:
            check(destination is not None, "legacy-intake: graduation requires a destination")
        if disposition == "graduated":
            check(state == "verified" and revision is not None and checksum is not None,
                  "legacy-intake: graduation requires immutable source and verified rights")
        if state in {"unknown", "restricted", "prohibited"}:
            check(not item["copied"] and disposition in {"quarantine", "archive-proposed", "archived", "rejected"},
                  "legacy-intake: blocked rights require metadata-only quarantine or rejection")
    return errors
