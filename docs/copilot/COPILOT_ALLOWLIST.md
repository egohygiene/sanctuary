<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [🤖 GitHub Copilot Cloud Agent Allowlist](#-github-copilot-cloud-agent-allowlist)
  - [Purpose](#purpose)
  - [Recommended Configuration](#recommended-configuration)
    - [Enable the Recommended Allowlist](#enable-the-recommended-allowlist)
  - [Repository Setup Steps](#repository-setup-steps)
  - [Repository Custom Allowlist](#repository-custom-allowlist)
    - [Current Repository Additions](#current-repository-additions)
      - [Poetry](#poetry)
      - [Trivy](#trivy)
      - [Goss](#goss)
  - [Security Guidelines](#security-guidelines)
    - [Preferred](#preferred)
    - [Avoid](#avoid)
  - [Troubleshooting](#troubleshooting)
    - [Firewall Blocked Connection](#firewall-blocked-connection)
  - [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 🤖 GitHub Copilot Cloud Agent Allowlist

## Purpose

This document describes the GitHub Copilot Cloud Agent firewall configuration
used by this repository.

The goal is to:

* minimize firewall-related failures
* preserve repository security
* document required external dependencies
* support reproducible Copilot agent execution

---

## Recommended Configuration

### Enable the Recommended Allowlist

GitHub provides a built-in recommended allowlist for Copilot Cloud Agent.

This allowlist already includes access to:

* common operating system package repositories
* common container registries
* common language package registries
* certificate authorities
* Playwright browser download infrastructure

Examples include:

* GitHub Container Registry
* Docker Hub
* npm
* PyPI
* Maven Central
* crates.io
* NuGet
* RubyGems
* Terraform Registry

The recommended allowlist should remain enabled whenever possible.

---

## Repository Setup Steps

This repository includes:

```text
.github/workflows/copilot-setup-steps.yml
```

Setup steps run before the Copilot Cloud Agent firewall is applied.

Use setup steps to:

* install repository tooling
* prepare development environments
* configure repository-specific dependencies
* perform diagnostics

Do not use setup steps to bypass security controls unnecessarily.

---

## Repository Custom Allowlist

Only add entries when:

* the dependency is required
* the dependency is trusted
* the dependency is documented

### Current Repository Additions

#### Poetry

```text
install.python-poetry.org
```

Purpose:

* Poetry installation

#### Trivy

```text
api.trivy.dev
aquasecurity.github.io
```

Purpose:

* vulnerability database updates
* security scanning

#### Goss

```text
goss.rocks
```

Purpose:

* validation and infrastructure testing

---

## Security Guidelines

### Preferred

* GitHub-hosted services
* official package registries
* official project download locations
* vendor-maintained infrastructure

### Avoid

* broad wildcard rules
* unknown domains
* temporary mirrors
* personal hosting providers
* undocumented dependencies

---

## Troubleshooting

### Firewall Blocked Connection

Copilot Cloud Agent may report:

```text
Firewall rules blocked me from connecting to ...
```

When this occurs:

1. Identify the blocked host.
2. Determine why the dependency is required.
3. Verify the host is trusted.
4. Add a documented allowlist entry if appropriate.
5. Re-run the workflow.

---

## References

GitHub Documentation:

* Copilot Allowlist Reference
* Customizing the Copilot Cloud Agent Firewall

---

Last Updated: 2026-06-20
Maintained By: Repository Maintainers
