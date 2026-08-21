# Incubations

Every substantial experiment or import lives in `incubations/<id>/` with a
valid `incubation.json`. The sibling [`index.json`](index.json) lists every
active and terminal record.

Do not place loose experimental source directly in this directory. Start from
the [minimal example](../examples/minimal/incubation.json), then follow the
[incubation lifecycle](../docs/incubation-lifecycle.md).

Terminal directories remain small provenance tombstones. They are not deleted
solely because work graduated, was archived, or was rejected.
