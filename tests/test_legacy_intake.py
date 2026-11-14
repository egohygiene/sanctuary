"""Synthetic provenance/accounting and explicit non-authority controls."""
from __future__ import annotations

from copy import deepcopy
import hashlib
import json
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from legacy_intake import validate_legacy_intake


class LegacyIntakeTests(unittest.TestCase):
    def setUp(self):
        self.example_root = ROOT / "examples/legacy-realignment"
        self.value = json.loads((self.example_root / "legacy-intake.json").read_text())

    def assert_invalid(self):
        self.assertTrue(validate_legacy_intake(self.value))

    def test_fixture_preserves_distinct_source_bytes_and_two_outcomes(self):
        self.assertEqual(validate_legacy_intake(self.value), [])
        self.assertTrue(self.value["synthetic"])
        for item in self.value["items"]:
            self.assertEqual(item["sha256"], hashlib.sha256((self.example_root / item["source_path"]).read_bytes()).hexdigest())
        self.assertNotEqual(self.value["items"][0]["sha256"], self.value["items"][1]["sha256"])
        self.assertEqual(self.value["items"][0]["version_group"], self.value["items"][1]["version_group"])
        self.assertEqual({item["disposition"] for item in self.value["items"]}, {"graduation-proposed", "archived"})

    def test_incomplete_inventory_cannot_disappear_into_a_smaller_count(self):
        self.value["items"].pop()
        self.assert_invalid()

    def test_duplicate_source_identity_and_id_are_rejected(self):
        self.value["items"][1] = deepcopy(self.value["items"][0])
        self.assert_invalid()

    def test_unknown_fields_do_not_admit_private_details(self):
        self.value["private_paths"] = ["synthetic-private-canary"]
        errors = validate_legacy_intake(self.value)
        self.assertTrue(errors)
        self.assertNotIn("synthetic-private-canary", str(errors))

    def test_unknown_rights_allow_only_uncopied_metadata(self):
        item = self.value["items"][0]
        item.update(license=None, license_state="unknown", disposition="quarantine", copied=False, destination=None, decision_reference=None)
        self.assertEqual(validate_legacy_intake(self.value), [])
        item["copied"] = True
        self.assert_invalid()

    def test_unknown_rights_cannot_become_a_graduation_proposal(self):
        item = self.value["items"][0]
        item.update(license_state="unknown", copied=False)
        self.assert_invalid()

    def test_missing_hashes_need_explicit_unavailable_reasons(self):
        item = self.value["items"][0]
        item.update(source_revision=None, sha256=None, copied=False, disposition="candidate")
        self.assert_invalid()
        item.update(revision_unavailable_reason="Synthetic unversioned source.", checksum_unavailable_reason="Metadata-only source.")
        self.assertEqual(validate_legacy_intake(self.value), [])

    def test_terminal_and_proposed_outcomes_require_separate_review_reference(self):
        self.value["items"][0]["decision_reference"] = None
        self.assert_invalid()

    def test_graduation_requires_destination_and_immutable_rights_evidence(self):
        item = self.value["items"][0]
        item.update(disposition="graduated", destination=None)
        self.assert_invalid()

    def test_private_exclusion_is_aggregate_only(self):
        self.value["excluded_private_count"] = 2
        self.assertEqual(validate_legacy_intake(self.value), [])
        self.value["excluded_private_count"] = True
        self.assert_invalid()

    def test_incubation_binding_is_checked(self):
        self.assertTrue(validate_legacy_intake(self.value, incubation_id="different-incubation"))

    def test_unsafe_paths_and_credential_references_are_rejected(self):
        for path in ("/tmp/private", "../parent", "source/../parent", r"C:\private", "source//file"):
            with self.subTest(path=path):
                value = deepcopy(self.value)
                value["items"][0]["source_path"] = path
                self.assertTrue(validate_legacy_intake(value))
        self.value["items"][0]["source_repository"] = "https://token@example.invalid/source"
        self.assert_invalid()

    def test_malformed_shapes_fail_without_echoing_rejected_input(self):
        for field in ("license_state", "disposition", "source_path", "source_repository", "source_revision", "destination"):
            with self.subTest(field=field):
                value = deepcopy(self.value)
                value["items"][0][field] = ["synthetic-private-canary"]
                errors = validate_legacy_intake(value)
                self.assertTrue(errors)
                self.assertNotIn("synthetic-private-canary", str(errors))

    def test_malformed_ipv6_and_nfkc_hosts_fail_without_input_echo(self):
        for field in ("source_repository", "decision_reference"):
            for url in ("https://[synthetic-private-canary", "https://synthetic-private-canary\uff0f.invalid/path"):
                with self.subTest(field=field, url=url):
                    value = deepcopy(self.value)
                    value["items"][0][field] = url
                    errors = validate_legacy_intake(value)
                    self.assertTrue(errors)
                    self.assertNotIn("synthetic-private-canary", str(errors))


if __name__ == "__main__":
    unittest.main()
