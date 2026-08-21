# Repository agent context

Before changing an incubation or Sanctuary's architecture:

1. Read [`ARCHITECTURE.md`](ARCHITECTURE.md).
2. Read [`docs/incubation-lifecycle.md`](docs/incubation-lifecycle.md).
3. Read the relevant record under [`docs/decisions/`](docs/decisions/).
4. Run `python3 tools/validate_incubations.py --include-examples` and
   `python3 -m unittest discover --start-directory tests --verbose`.

Sanctuary owns bounded incubation, provenance, lifecycle evidence, and
graduation proposals for unfinished or ownerless work. It does not own the
durable implementation of a capability after an ownership decision.

Do not add secrets, private data, machine-specific state, large generated
artifacts, or source whose license and provenance are unknown. Stable
repositories must not depend on mutable Sanctuary source.

Every substantial incubation lives under `incubations/<id>/` and has a valid
`incubation.json`. Update `incubations/index.json` in the same change. Never
change a lifecycle state without preserving the reason and review evidence in
the manifest.
