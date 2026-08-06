# Ego Hygiene Playground Recommendations

- Expand the existing `apps/playground` workspace application instead of adding a second root-level playground.
- Use the playground as a real React and Vite environment for visual experiments, prototypes, integration trials, and workspace-package testing.
- Keep the playground separate from the production `egohygiene.io` application.

## Suggested structure

- Keep application setup under `apps/playground/src/app`.
  - `App.tsx`
  - `providers.tsx`
- Add reusable playground-only interface components under `apps/playground/src/components`.
  - `ExperimentCard.tsx`
  - `ExperimentLayout.tsx`
  - `ExperimentNavigation.tsx`
- Store experiments under `apps/playground/src/experiments`.
  - Add an `_template` directory for starting new experiments consistently.
  - Add a `registry.ts` file to make experiments discoverable and navigable.
  - Add a `types.ts` file for shared experiment metadata.
  - Organize experiments by concept, such as:
    - `design-tokens`
    - `knowledge-graph`
    - `landing-scene`
    - `motion`
    - `shaders`
    - `themes`
- Give each substantial experiment its own directory.
  - Main experiment component
  - Optional controls
  - Optional fixtures
  - Barrel export
  - Short `README.md`
- Keep playground-specific assets under `apps/playground/public/assets`.

## Experiment documentation

- Record what each experiment is testing.
- Explain why the experiment exists.
- Track its current status.
- Record important discoveries and limitations.
- State whether it should be promoted, retained, archived, or deleted.

## TypeScript configuration

- Keep the TypeScript configuration local at `apps/playground/tsconfig.app.json`.
- Extend the repository-level `tsconfig.base.json`.
- Enable the React JSX runtime.
- Include browser libraries and Vite client types.
- Add an app-local alias such as `@playground/*` mapped to `src/*`.
- Keep `noEmit: true` because Vite owns application output.
- Include application source files through `src`.
- Exclude generated output, coverage, dependencies, tests, and stories from the application config.
- Type-check tests and stories through their dedicated Vitest and Storybook configurations.
- Reference `apps/playground/tsconfig.app.json` from the root `tsconfig.typecheck.json`.
- Do not restore the old root-level `tsconfig.playground.json`.

## Dependency boundaries

- Allow `apps/playground` to import shared workspace packages.
- Do not allow production applications or packages to import from `apps/playground`.
- Do not allow `packages/*` to import from any application.
- Avoid treating experimental code as an implicit shared library.

## Promotion workflow

- Begin new concepts as playground experiments.
- Validate the interaction, architecture, and performance in isolation.
- Promote successful reusable UI into `packages/ui`.
- Promote reusable rendering and Three.js abstractions into `packages/visualizations`.
- Promote approved design values into `packages/design-tokens`.
- Promote approved themes into `packages/themes`.
- Promote website-specific landing experiences into `apps/egohygiene.io/src/features/landing`.
- Split knowledge visualizations between shared visualization primitives and app-specific knowledge features when appropriate.
- Archive or delete the experiment after its useful work has been promoted.

## Experiment registry

- Give every registered experiment:
  - A stable identifier
  - A title
  - A short description
  - A lifecycle status
  - Searchable tags
  - A component or lazy component loader
- Use lifecycle states such as:
  - `idea`
  - `active`
  - `stable`
  - `archived`
- Eventually expose the registry through a searchable playground dashboard.
- Prefer lazy-loading experiments so large 3D or visualization dependencies are loaded only when needed.

## Operational safeguards

- Set the playground package to `"private": true`.
- Block search indexing through the playground's `robots.txt`.
- Exclude the playground from the production website deployment.
- Keep experimental environment variables separate from production configuration.
- Never place production secrets in the playground.
- Allow experiments to be imperfect, but keep the playground itself type-safe and runnable.
