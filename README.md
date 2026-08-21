# Sanctuary

🌱 A bounded incubation workspace for Ego Hygiene experiments, imports,
prototypes, and concepts that do not yet have durable ownership.

> **Status:** provisional bootstrap. The local incubation contract is proposed
> for review and must not be treated as an organization-wide standard until
> Hygiene adopts and releases it.

Sanctuary answers one question: **where can unfinished or ownerless work live
safely while it is being understood?**

```text
idea / import / experiment
        -> Sanctuary intake
        -> explore with provenance
        -> explicit ownership decision
        -> existing owner or separately approved new repository
        -> versioned release and normal lifecycle
```

## Boundaries

Sanctuary is intentionally permissive about implementation choices, but strict
about provenance, public-data safety, ownership, and exit conditions.

It is not:

- a second Empathy or a canonical repository template;
- a permanent source for specialist implementations;
- an untracked dumping ground or generic artifact archive;
- a production dependency, secret store, or state backend; or
- a substitute for deciding who owns a durable capability.

Empathy remains the strict golden baseline. Hygiene defines organization
architecture and the canonical repository catalog. Holon creates from approved
blueprints. Pace may later propose reviewable baseline upgrades. Sanctuary
incubations graduate to an existing owner whenever one fits; a new repository
requires a separate organization decision.

## Start an incubation

1. Copy [`examples/minimal/incubation.json`](examples/minimal/incubation.json)
   to `incubations/<id>/incubation.json`.
2. Record every source, its immutable revision when available, license,
   attribution, owner, reviewers, question, candidate destinations, and exit
   criteria.
3. Add the matching summary to [`incubations/index.json`](incubations/index.json).
4. Validate before opening a pull request:

   ```shell
   python3 tools/validate_incubations.py --include-examples
   python3 -m unittest discover --start-directory tests --verbose
   ```

5. Keep experimental source inside its incubation directory. Do not copy it
   into another repository without an approved graduation decision and
   preserved provenance.

See the [incubation lifecycle](docs/incubation-lifecycle.md) for state
transitions, graduation, rejection, and archival rules.

## Repository map

- [`ARCHITECTURE.md`](ARCHITECTURE.md) — ownership and ecosystem boundaries.
- [`ROADMAP.md`](ROADMAP.md) — bootstrap and promotion gates.
- [`docs/incubation-lifecycle.md`](docs/incubation-lifecycle.md) — operating
  contract.
- [`schemas/incubation-manifest.v1.schema.json`](schemas/incubation-manifest.v1.schema.json)
  — machine-readable manifest shape.
- [`incubations/index.json`](incubations/index.json) — authoritative local
  inventory.
- [`tools/validate_incubations.py`](tools/validate_incubations.py) — dependency-free
  structural and cross-file validation.

## License

Sanctuary's repository-owned documentation and tooling are available under the
[MIT License](LICENSE). Imported or incubated material retains its own recorded
license; placement in Sanctuary never relicenses upstream work.
