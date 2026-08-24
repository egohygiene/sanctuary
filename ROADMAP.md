# Sanctuary Roadmap

<!-- BEGIN ROADMAP EXECUTION SNAPSHOT -->
<!-- roadmap-manifest
schema: hygiene.roadmap/v1alpha1
repository: egohygiene/sanctuary
visibility: public
publication: central
route: /roadmap/sanctuary/
updated: 2026-08-24
-->
## 2026-08-24 execution snapshot

> This evidence-reconciled snapshot is the issue-generation and visual-roadmap handoff. The longer-horizon strategy below remains canonical context; generated HTML, JSON, progress, issue plans, and commit lists are projections.

**Lifecycle:** validated bootstrap  
**Current gate:** Register the contract in Hygiene and put one real incubation through the currently empty index.  
**North-star outcome:** A safe, evidence-driven incubation lifecycle from intake through graduation, transfer, archival, or rejection.

### Visual roadmap publication

**Mode:** `central`  
**Route:** `/roadmap/sanctuary/`  
**Current publication evidence:** Validated source registry; no public site or release observed.

Publish the public-safe projection through egohygiene.io at /roadmap/sanctuary/. This repository owns intent and acceptance evidence; it does not add a second site deployment.

### Quest line

<!-- roadmap-step
id: SAN-Q01
status: complete
depends_on: []
issues: []
-->
#### SAN-Q01 — Build the incubation contract

**State:** `complete`  
**Depends on:** None

**Outcome:** Schema, validator, tests, and CI provide a green bootstrap for incubation records.

**Exit criteria:**

- [x] The schema and validator reject invalid fixtures.
- [x] Default-branch CI is green.

**Current evidence:**

- Schema, validator, tests, and green CI were observed.

<!-- roadmap-step
id: SAN-Q02
status: active
depends_on: [SAN-Q01]
issues: []
-->
#### SAN-Q02 — Register Sanctuary in Hygiene

**State:** `active`  
**Depends on:** `SAN-Q01`

**Outcome:** Hygiene recognizes Sanctuary as the authoritative incubation registry.

**Exit criteria:**

- [ ] The Hygiene catalog and boundary contract point to Sanctuary.
- [ ] Schema version ownership is explicit.

**Current evidence:**

- Hygiene registration is the current cross-repository gate.

<!-- roadmap-step
id: SAN-Q03
status: ready
depends_on: [SAN-Q02]
issues: []
-->
#### SAN-Q03 — Process the first real intake

**State:** `ready`  
**Depends on:** `SAN-Q02`

**Outcome:** A real candidate moves from intake into an owned incubation state with evidence.

**Exit criteria:**

- [ ] The index contains at least one non-fixture record.
- [ ] Owner, hypothesis, risk, review date, and evidence links are complete.

**Current evidence:**

- The incubation index was empty at audit time.

<!-- roadmap-step
id: SAN-Q04
status: planned
depends_on: [SAN-Q03]
issues: []
-->
#### SAN-Q04 — Prove a terminal lifecycle decision

**State:** `planned`  
**Depends on:** `SAN-Q03`

**Outcome:** One incubation reaches graduation, transfer, archival, or rejection with a reviewable rationale.

**Exit criteria:**

- [ ] The terminal transition satisfies the contract.
- [ ] Artifacts and ownership are handled according to the recorded decision.

**Current evidence:**

- No real intake or terminal lifecycle decision was observed.

<!-- roadmap-step
id: SAN-Q05
status: planned
depends_on: [SAN-Q04]
issues: []
-->
#### SAN-Q05 — Refine, automate, and release the proven contract

**State:** `planned`  
**Depends on:** `SAN-Q04`

**Outcome:** Only repeated, demonstrated lifecycle steps become automation in a versioned release.

**Exit criteria:**

- [ ] Post-pilot contract changes are documented with migration guidance.
- [ ] A tagged release and reusable validation path are published.

**Current evidence:**

- No release was observed; automation is intentionally sequenced after a real lifecycle.

### Roadmap-to-issue handoff

- A step is complete only when its exit criteria and required evidence are satisfied; commit count never determines progress.
- Ready or planned steps without an issue are candidates for the private, duplicate-aware roadmap.issue-plan.json dry run.
- Issue creation or reconciliation requires human approval or an explicitly authorized Pace operation and returns issue references through a reviewable roadmap pull request.
- Pull requests and commits should include Roadmap-Step: <ID>; historical evidence may be linked through existing issue and pull-request relationships.
- Public rendering uses only allowlisted build-time evidence and never places a GitHub token or private issue plan in the browser artifact.

<!-- END ROADMAP EXECUTION SNAPSHOT -->

Status: **provisional**

## Phase 0 — approve the local incubation contract

- Review the Sanctuary purpose, lifecycle, trust boundary, and non-goals.
- Review the v1 manifest schema, example, validator, and empty index.
- Confirm Holon and Pace behavior is explicit and bounded.

Exit gate: the bootstrap pull request is approved and merged.

## Phase 1 — register Sanctuary in Hygiene

- Add the already-created public repository to Hygiene's observed catalog.
- Define Sanctuary's ownership, exclusions, outputs, and lifecycle in canonical
  ecosystem context.
- Add only the cross-repository relationships needed to route intake and
  graduation.
- Generate Sanctuary's pinned local ecosystem context from the accepted
  Hygiene revision.

Exit gate: one separately reviewed Hygiene projection pull request is merged.

## Phase 2 — prove one bounded incubation

- Select one small, public, license-compatible experiment with no current
  durable owner.
- Exercise intake, exploration, evidence capture, review, and one terminal
  decision.
- Record friction before generalizing the schema or automation.

Exit gate: one real incubation can be understood and reproduced from its
record without maintainer memory.

## Phase 3 — automate only proven repetition

- Let Holon publish an approved incubator blueprint if repeated creation demand
  exists.
- Let Pace propose managed-baseline updates without touching incubation-owned
  content.
- Let Observatory consume public lifecycle evidence read-only.
- Move reusable validation mechanics to their durable owner if multiple
  repositories need them.

Exit gate: every automation boundary uses a versioned contract and preserves
human review.

## Explicitly deferred

- Bulk migration of historical Empathy staging content.
- Automatic graduation or repository creation.
- Organization-wide canonical lifecycle semantics before Hygiene approval.
- Artifact storage, secret management, private-data handling, or production
  deployment.
