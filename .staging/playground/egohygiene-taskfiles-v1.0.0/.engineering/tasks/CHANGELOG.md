# Changelog

## 1.0.0 - 2026-07-22

- Reduced the root Taskfile to a required module-routing table.
- Extracted Flutter automation into a flattened application module.
- Added a flattened project module for default, version, platform, and doctor.
- Extracted Copilot hook tasks into their own namespace.
- Preserved existing root-level application task names.
- Added override-friendly absolute paths derived from `ROOT_DIR`.
- Added internal precondition tasks and actionable failure messages.
- Added confirmation protection to the destructive FVM reset.
- Corrected application cleanup working-directory behavior.
- Made aggregate builds host-aware through platform restrictions.
- Replaced the integration-test inline shell block with a lifecycle-safe runner.
- Standardized Git commands and made the heatmap portable to macOS and Linux.
- Corrected Lynis execution and routed its reports into `.engineering/reports`.
- Removed forced color output and optional committed-module includes.

