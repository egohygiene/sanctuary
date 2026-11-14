# Legacy realignment intake

This provisional Sanctuary profile extends the existing [incubation lifecycle](incubation-lifecycle.md).
It records public source fragments and competing versions before any ownership,
merge, transfer or retirement decision. It does not reinstate a catch-all archive
or grant rights to imported material.

1. Define a finite source scope and inventory every public item before copying.
   Keep original repository, relative path, exact commit and SHA-256 where
   available. Missing identity evidence requires an explicit reason, not a
   fabricated hash. Record purpose, attribution and license state separately.
2. Create the normal `incubation.json` and index row. Beside it, add
   `legacy-intake.json` conforming to the [versioned schema](../schemas/legacy-intake.v1.schema.json).
   The optional profile does not replace the incubation manifest or its lifecycle.
3. Preserve each competing version as a distinct immutable source identity.
   Use `version_group` to identify competing candidates. Do not overwrite or
   synthesize a preferred file before recording the source mapping, differences,
   chosen behavior, rejected alternatives and rationale in the review.
4. Keep unknown, restricted or prohibited rights **metadata only** in quarantine
   or a rejection/archive proposal. Copying requires verified rights and a
   checksum. License verification is a human evidence judgment; a validator
   accepts the claim's shape and never verifies ownership or compatibility.
5. Prefer an existing Hygiene catalog owner. Candidate destinations are proposals,
   not acceptance. Source/runtime tools usually belong to Mantle, runtime
   environments to Realm, asset identity to Identity, and reusable workflows to
   Relay. Verify current catalog responsibilities before every decision.

Private, personal, secret-bearing or human-only material must never enter this
public inventory: no names, paths, titles, hashes, snippets or links. Record only
an aggregate `excluded_private_count` after human separation outside Sanctuary.
This count is a declaration, not an assertion that private material was inspected
or safely retired. Do not scan or import private source to populate it.

## Exit gates

| Disposition | Evidence and next owner |
| --- | --- |
| Candidate | Preserve original source and explicit candidate owner; no transfer. |
| Graduation proposed | Separate review reference, destination, source mapping, rights evidence, validation and migration/recovery plan. |
| Graduated | Durable owner acceptance and immutable destination evidence, verified rights and source commit/checksum; update the incubation lifecycle through its normal review. |
| Archive proposed / archived | Preserve source/decision context, reason and recovery location; do not erase the ledger. Unknown-license content remains uncopied. |
| Rejected | Record why and link the review; preserve only public metadata that is safe and lawful to retain. |
| Quarantine | Metadata only, unresolved rights/ownership or provenance; no canonical consumer may depend on it. |

An unavoidable new-owner proposal requires a separate Hygiene ownership decision;
Sanctuary cannot create an owner by naming it. A review reference is not proof
of approval, and a structurally valid `graduated` record is not a verified
transfer receipt. Stable repositories must use the durable owner's versioned
interface, never mutable Sanctuary paths.

## Repository-retirement review

Before a separate request to archive or delete a legacy repository:

- Reconcile the exact source revision and finite scope with every ledger item;
  the expected public count must match, and the human inventory must be complete.
- Resolve every candidate, proposal and quarantine item or preserve an explicit
  retained source location. Two competing versions must not disappear into one.
- Verify every destination's acceptance, immutable recovery references, rights,
  tests and source-to-destination mapping independently of this validator.
- Obtain a human disposition for excluded private material outside this public
  profile. Aggregate counts provide no deletion authority.
- Verify rollback/recovery and consumer migration. Preserve the ledger/index
  tombstone and decision rationale.
- Request separate explicit authorization for the exact repository archive or
  deletion operation. This profile performs neither operation.

## Synthetic example and validation

[`examples/legacy-realignment/`](../examples/legacy-realignment/) contains three
repository-owned MIT fixture files: two competing helper versions proposed for
Mantle and an obsolete note archived in the example. All repository/review
references use `example.invalid`; the fixtures prove accounting and proposed
outcomes, not actual owner acceptance. No historical source is imported.

Run the existing canonical commands:

```sh
python3 tools/validate_incubations.py --include-examples
python3 -m unittest discover --start-directory tests --verbose
```

The validator checks optional ledgers in registered incubations and this example,
including identity uniqueness, competing-version preservation, rights/copy gates
and decision references. It never fetches links, reads original repositories,
imports fragments, changes lifecycle state or retires repositories.
