"""Tests for the Sanctuary incubation validator."""

from __future__ import annotations

import copy
import importlib.util
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "validate_incubations", ROOT / "tools" / "validate_incubations.py"
)
if SPEC is None or SPEC.loader is None:
    raise RuntimeError("could not load validator")
validator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(validator)


class IncubationManifestTests(unittest.TestCase):
    """Exercise the v1 manifest rules."""

    @classmethod
    def setUpClass(cls) -> None:
        cls.example = json.loads(
            (ROOT / "examples" / "minimal" / "incubation.json").read_text(encoding="utf-8")
        )

    def test_example_is_valid(self) -> None:
        self.assertEqual([], validator.validate_manifest(self.example, "example"))

    def test_unknown_state_is_rejected(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["state"] = "forgotten"
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any(".state" in error for error in errors))

    def test_private_data_is_rejected(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["data_classification"] = "private"
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any("accepts only 'public'" in error for error in errors))

    def test_import_requires_url_and_allows_unversioned_source(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["sources"][0]["kind"] = "import"
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any("requires a URL" in error for error in errors))

        candidate["sources"][0]["url"] = "https://example.com/source"
        errors = validator.validate_manifest(candidate, "example")
        self.assertFalse(any(".revision" in error for error in errors))

    def test_graduation_requires_approved_destination(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["state"] = "graduated"
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any("requires 'approved'" in error for error in errors))
        self.assertTrue(any("graduated work requires" in error for error in errors))

    def test_expiring_exception_is_structured(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["baseline_exceptions"] = [
            {
                "rule": "Use the standard build profile.",
                "rationale": "The experiment tests an unsupported runtime.",
                "approved_by": "szmyty",
                "expires_at": "not-a-date",
            }
        ]
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any("expires_at" in error for error in errors))

    def test_unknown_fields_are_rejected(self) -> None:
        candidate = copy.deepcopy(self.example)
        candidate["mystery"] = True
        errors = validator.validate_manifest(candidate, "example")
        self.assertTrue(any("unknown field 'mystery'" in error for error in errors))


class RepositoryContractTests(unittest.TestCase):
    """Exercise the checked-in repository projection."""

    def test_repository_contract_is_valid(self) -> None:
        self.assertEqual([], validator.validate_repository(include_examples=True))


if __name__ == "__main__":
    unittest.main()
