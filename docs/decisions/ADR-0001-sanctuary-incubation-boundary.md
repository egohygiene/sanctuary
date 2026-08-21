# ADR-0001 — Establish Sanctuary as a bounded incubation workspace

- **Status:** Proposed
- **Date:** 2026-08-21
- **Decision owner:** `egohygiene/sanctuary`
- **Organization authority:** `egohygiene/hygiene`
- **Organization intake:** [`egohygiene/.github#12`](https://github.com/egohygiene/.github/issues/12)
- **Depends on:** [`egohygiene/empathy#66`](https://github.com/egohygiene/empathy/pull/66), [`egohygiene/hygiene#9`](https://github.com/egohygiene/hygiene/pull/9)

## Context

Empathy historically combined a repository baseline, integration testbed, and
incubation area. Its accepted local ownership decision now makes Empathy the
strict golden baseline and routes new general experimentation elsewhere.

The organization needs a place where unfinished or ownerless public work can be
understood without pretending it is stable. An unconstrained dumping ground
would reproduce the ownership ambiguity Sanctuary is meant to resolve.

## Decision

Establish Sanctuary as an intentionally permissive but bounded incubation
workspace.

Every substantial incubation has:

1. a directory-local v1 JSON manifest;
2. source license, attribution, and provenance;
3. a current lifecycle state;
4. a named owner and reviewers;
5. one question, candidate destinations, and exit criteria;
6. explicit, expiring baseline exceptions; and
7. an indexed decision trail that ends in graduation, archival, or rejection.

The lifecycle is local and provisional until Hygiene approves an
organization-wide contract. Stable repositories may not depend on mutable
Sanctuary source.

Holon may eventually create the Sanctuary repository class from an approved
blueprint. Pace may later propose reviewable changes to managed baseline files.
Neither system may silently create, alter, graduate, archive, or reject an
incubation.

## Consequences

- Experiments can move quickly without losing provenance or ownership intent.
- Empathy can become stricter without forcing premature repository creation.
- Maintaining manifests and index entries adds deliberate overhead.
- Graduation remains a human-reviewed migration, not an automated state flip.
- Hygiene requires a separate follow-up to add the live repository and accepted
  boundary to the canonical catalog.

## Alternatives rejected

### Continue using Empathy as the general incubator

Rejected because it conflicts with Empathy's strict baseline role and keeps
physical source location ambiguous.

### Create a new repository for every experiment

Rejected because repository creation would happen before durable ownership is
proven and would expand the fleet unnecessarily.

### Use issues or an unstructured staging directory only

Rejected because imported source, executable prototypes, provenance evidence,
and terminal decisions need a durable, validated local record.

### Automatically graduate work based on maturity metrics

Rejected because metrics cannot accept ownership, license risk, trust
boundaries, maintenance cost, or architectural fit on behalf of a maintainer.

## Replacement and exit strategy

Hygiene may supersede the local schema and lifecycle with a released canonical
contract. Migration must preserve record identity, source provenance, decisions,
and terminal tombstones. If Sanctuary itself proves unnecessary, active work is
routed through explicit ownership decisions and its remaining records become a
read-only provenance archive.

## Approval gates

- Approve the local purpose, non-goals, lifecycle, and schema.
- Merge the dependency-free validator and empty index.
- Add Sanctuary to Hygiene only in a separate reviewed projection after this
  bootstrap is accepted.
- Prove the process with one real bounded incubation before broad automation.
