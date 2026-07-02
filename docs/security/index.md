# Security

This section documents the security tooling, supply chain protections, and vulnerability
intelligence capabilities integrated into Sanctuary.

These tools form a cohesive security and governance layer designed to be reusable across
the Ego Hygiene ecosystem.

---

## Supply Chain Security Overview

Sanctuary implements a layered security approach spanning static analysis, dependency
auditing, vulnerability intelligence, repository health scoring, and license governance.

| Tool | Purpose | Trigger |
|---|---|---|
| [CodeQL](#codeql) | Static application security testing (SAST) | Push, PR, Schedule |
| [Dependency Review](#dependency-review) | Block vulnerable dependency introductions | Pull requests |
| [OSV Scanner](#osv-scanner) | Lockfile vulnerability scanning via OSV.dev | Push, PR, Schedule |
| [OpenSSF Scorecard](#openssf-scorecard) | Repository security posture scoring | Push, Schedule |
| [Dependabot](#dependabot) | Automated dependency version updates | Weekly schedule |
| [REUSE Compliance](#reuse-compliance) | SPDX license and copyright validation | Push, PR |

---

## CodeQL

**Workflow:** `.github/workflows/codeql.yml`

CodeQL performs static application security testing (SAST) across supported languages in
the repository. It identifies security vulnerabilities and code quality issues by analyzing
source code semantics rather than surface patterns.

**Languages scanned:** GitHub Actions, JavaScript/TypeScript, Python

**Integration:** Results are published to GitHub Security Code Scanning and surfaced as
alerts in the Security tab.

---

## Dependency Review

**Workflow:** `.github/workflows/dependency-review.yml`

The Dependency Review action inspects dependency changes introduced in pull requests and
blocks merges when:

- A new dependency carries a known vulnerability with high or critical severity.
- A new dependency introduces a denied license (GPL-2.0, GPL-3.0, AGPL-3.0 variants).

**Integration:** Results are posted as a pull request comment summary.

---

## OSV Scanner

**Workflow:** `.github/workflows/osv-scan.yml`

The [OSV Scanner](https://google.github.io/osv-scanner/) scans repository lockfiles against
the [Open Source Vulnerabilities (OSV)](https://osv.dev/) database maintained by Google.

OSV aggregates vulnerability data from multiple sources including:

- GitHub Security Advisories (GHSA)
- National Vulnerability Database (NVD)
- Python Packaging Advisory Database (PyPA)
- RustSec Advisory Database
- Go Vulnerability Database
- And many more ecosystem-specific sources

**Scanned manifests:**

- `pnpm-lock.yaml` — Node.js / pnpm dependencies
- `poetry.lock` — Python / Poetry dependencies

**Triggers:**

- Push to `main`/`master` when lockfiles change
- Pull requests that modify lockfiles
- Weekly scheduled scan (Wednesdays at 04:00 UTC) to detect newly published CVEs
- Manual dispatch

**Integration:** Results are published to GitHub Security Code Scanning in SARIF format.

---

## OpenSSF Scorecard

**Workflow:** `.github/workflows/ossf-scorecard.yml`

[OpenSSF Scorecard](https://securityscorecards.dev/) evaluates the overall security posture
of the repository against a standardized set of supply-chain security best practices.

**Score categories evaluated:**

| Category | Description |
|---|---|
| Branch Protection | Enforcement of branch protection rules |
| Code Review | Requirement for code review on changes |
| CI Tests | Presence and reliability of CI testing |
| Maintained | Commit activity and release cadence |
| Dependency Update Tool | Automated dependency updates (Dependabot) |
| Token Permissions | Principle of least privilege for workflow tokens |
| Pinned Dependencies | Use of pinned action SHAs |
| SAST | Static analysis tooling presence |
| Vulnerabilities | Outstanding known vulnerabilities |
| Signed Releases | Cryptographic signing of release artifacts |

**Triggers:**

- Push to `main`/`master`
- Weekly scheduled scan (Mondays at 05:00 UTC)
- Manual dispatch

**Integration:** Results are published to GitHub Security Code Scanning and to the public
Scorecard API at `https://securityscorecards.dev/viewer/?uri=github.com/egohygiene/sanctuary`.

---

## Dependabot

**Configuration:** `.github/dependabot.yml`

Dependabot automates dependency version update pull requests on a weekly schedule for:

- GitHub Actions workflows
- Node.js / pnpm packages (`package.json`)
- Python / Poetry packages (`pyproject.toml`)

Dependabot security alerts are enabled separately through GitHub repository settings and
are independent of the version update schedule.

---

## REUSE Compliance

**Workflow:** `.github/workflows/reuse.yml`

REUSE compliance validates that every file in the repository carries an SPDX license
identifier and copyright declaration, either inline or via `REUSE.toml`.

This ensures the repository meets the [REUSE Specification](https://reuse.software/spec/)
and supports downstream license compliance and SBOM generation.

---

## Future Integrations

The following tools are staged in `.github/workflows/future/` and are candidates for
activation as the governance stack matures:

| Tool | Purpose |
|---|---|
| Gitleaks | Secret and credential scanning |
| CycloneDX SBOM | Software Bill of Materials generation |
| Scancode Toolkit | Deep license and copyright discovery |
| ClearlyDefined | Dependency license metadata quality |
| DCO Enforcement | Developer Certificate of Origin sign-off |

---

## OSS-Fuzz Evaluation

[OSS-Fuzz](https://google.github.io/oss-fuzz/) provides continuous fuzz testing for
open-source projects. The following evaluation was conducted against the Sanctuary
repository to determine applicability.

### Findings

**Current status:** Not applicable at this time.

**Rationale:**

OSS-Fuzz is designed for projects that expose security-critical interfaces to untrusted
input — typically parsers, serializers, network protocols, cryptographic implementations,
and similar low-level components. Sanctuary is an engineering foundation repository
containing:

- Shell configuration and utilities
- GitHub Actions automation workflows
- Documentation and knowledge artifacts
- Development tooling configuration

None of these components expose a fuzz-testable API surface or process untrusted binary
input in a way that would benefit from fuzz testing.

**Future consideration:**

If Sanctuary evolves to include a component that:

- Parses untrusted structured input (e.g. a config file parser)
- Implements a network protocol or serialization format
- Exposes a public library API in a compiled language (C, C++, Rust, Go)

…then OSS-Fuzz integration should be re-evaluated at that time. The project would
need to provide fuzz targets and register at
[google/oss-fuzz](https://github.com/google/oss-fuzz).

---

## Reusability

All workflows in this security layer are designed for reuse across the Ego Hygiene
ecosystem. To adopt them in a new repository:

1. Copy the relevant workflow files from `.github/workflows/` into the target repository.
2. Update the `on.push.branches` and `on.pull_request.branches` triggers if needed.
3. Adjust the scanned lockfile paths in `osv-scan.yml` to match the target repository's
   package managers.
4. For OpenSSF Scorecard with `publish_results: true`, the repository must be public or
   have the appropriate GitHub Advanced Security license.

No secrets or repository-specific configuration are required for any of these workflows
beyond a standard `GITHUB_TOKEN`.
