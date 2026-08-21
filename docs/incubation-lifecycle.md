# Incubation lifecycle

This document is Sanctuary's provisional local operating contract. Hygiene may
later adopt, replace, or version an organization-wide policy; until then, these
states describe only records in this repository.

## What counts as substantial

An experiment is substantial when it includes imported source, executable code,
a reusable specification, a non-trivial dataset, or work expected to survive
beyond a single pull request discussion. Substantial work must have its own
directory and manifest before source is added.

Tiny notes may remain in an issue until they become substantial. Large binary
artifacts, raw archives, and private material belong with their durable storage
owner, not in Sanctuary.

## States

| State | Meaning | Required evidence |
| --- | --- | --- |
| `intake` | The work is identified and safe to inspect, but its value or owner is not yet established. | Question, owner, reviewers, sources, license/provenance, candidate destinations, exit criteria. |
| `exploring` | Bounded work is actively testing the recorded question. | Current findings, validation path, reviewed baseline exceptions. |
| `graduating` | A concrete ownership proposal is under review. | Destination, decision issue or pull request, migration/recovery plan, validation evidence. |
| `graduated` | A durable owner accepted the work. | Approved decision, destination, decision date, rationale, and destination evidence. |
| `archived` | Useful evidence is retained, but active work stopped without a durable transfer. | Reviewed decision and reason; enough source context to understand the experiment. |
| `rejected` | The experiment or proposal should not continue in its current form. | Reviewed decision and reason, including safety, duplication, license, or evidence concerns. |

`graduated`, `archived`, and `rejected` are terminal for the recorded decision.
Archived or rejected work may return to `exploring` only through a new reviewed
change that explains what new evidence changed the decision.

## Allowed transitions

```text
intake      -> exploring | archived | rejected
exploring   -> graduating | archived | rejected
graduating  -> exploring | graduated | rejected
archived    -> exploring
rejected    -> exploring
graduated   -> terminal
```

The manifest records the current state and `updated_at`. Pull request history is
the append-only transition ledger. A state-changing pull request explains the
prior state, next state, evidence, and reviewer decision.

## Ownership decisions

Every manifest carries a decision object:

- `pending` while the record is in `intake` or `exploring`;
- `proposed` while it is `graduating`; and
- `approved` or `rejected` for a terminal state.

Graduation prefers an existing coherent owner. Creating a new repository is not
a Sanctuary-local decision; it requires separate Hygiene approval. A candidate
destination is a hypothesis, not ownership authority.

## Provenance and licensing

Each source records:

- `kind`: `original` or `import`;
- a stable URL for imported work;
- an immutable revision for imported work when one exists;
- the source's SPDX license identifier or `LicenseRef-*` identifier;
- required attribution; and
- the date it was recorded.

Unknown or incompatible licensing blocks source import. A manifest may describe
the question without copying blocked source. Sanctuary's MIT license applies
only to repository-owned work that is actually offered under it.

## Baseline exceptions

Experiments may temporarily bypass non-safety baseline rules. Each exception
requires:

- the exact rule being bypassed;
- why the experiment needs the exception;
- the approving GitHub login; and
- an ISO 8601 expiry date.

No exception can permit secrets, private data, missing provenance, unknown
licensing, or unreviewed production dependency.

## Retention and cleanup

Terminal records stay in the index. Generated artifacts and replaceable caches
are removed. The retained directory contains the manifest, a concise README,
essential source or links, decision evidence, and recovery/provenance details.

Cleanup must preserve enough information to answer:

1. What was tried?
2. Where did it come from?
3. What question did it test?
4. What evidence was produced?
5. Why did it graduate, stop, or fail?
6. Where does durable work live now?
