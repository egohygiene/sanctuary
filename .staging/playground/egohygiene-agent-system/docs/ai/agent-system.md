# Agent System

This bundle turns the supplied collection into one composable system:

> Instructions define persistent repository rules. Specs define required outcomes. Skills define reusable methods. Agents define specialist roles. Issues and prompts select the work to perform now.

These layers are intentionally not one-to-one. Agents compose skills, and both can follow several specifications.

## Included specialists

| Agent | Primary skill | Governing specification |
|---|---|---|
| Architect | `architecture-authoring` | Most specific contract under `.github/specs/architecture/` |
| arXiv Publisher | `arxiv-publishing` | `arxiv.spec.md` |
| Auditor | `repository-audit` | `auditor.spec.md` |
| Bug Fix Teammate | `bug-fixing` | Applicable task or domain spec |
| Cleanup Specialist | `repository-cleanup` | Repository instructions and applicable domain spec |
| Flutter Engineer | `flutter-engineering` | `flutter-engineer.spec.md` plus feature specs |
| GitHub Issue Creator | `github-issue-authoring` | `github-issue-creator.spec.md` and optional exact-format contract |
| Implementation Planner | `implementation-planning` | Approved architecture and feature specs |
| Specfile Creator | `spec-authoring` | `specfile.spec.md` |
| Test Specialist | `test-engineering` | Repository strategy or `testing-strategy.spec.md` |
| Knowledge Extractor | `knowledge-extraction` | `knowledge-extract.spec.md` and optional source-capture spec |
| Synapse Creator | `synapse-creation` | `synapse-create.spec.md` |

The standalone `skill-authoring` skill maintains this capability layer without requiring a dedicated role agent.

## Key structural decisions

- Project skills live in `.agents/skills/` for broad Agent Skills compatibility.
- Custom agents live in `.github/agents/`, the shared workspace location recognized by GitHub Copilot and VS Code.
- Skill frontmatter uses only `name` and `description` for portability.
- Agent frontmatter uses current `user-invocable` and `disable-model-invocation` properties instead of deprecated `infer`.
- Agent profiles omit `version` and `status`; source control owns history and lifecycle.
- Tool access is role-specific. Read-only authors do not receive edit or execute capabilities unless their artifact requires it.
- Detailed Flutter material lives under the Flutter skill's `references/` directory and loads only when relevant.
- Agent files formerly stored in the specs archive are restored to `.github/agents/`.
- `.DS_Store` files are excluded.

## Adding a capability

1. Decide whether the new information is a persistent rule, requirement contract, reusable procedure, role, or immediate task.
2. Add the smallest missing layer; do not create a complete four-file set merely for symmetry.
3. Link the agent to the skill and the skill or agent to applicable specs.
4. Give one artifact canonical ownership of each rule.
5. Run `.agents/scripts/validate-agent-system.sh`.
6. Test the capability with a representative request before relying on it for autonomous work.

See `.github/specs/agent-system.spec.md` for the normative contract.
