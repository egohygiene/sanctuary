# website

This monorepo contains the source for the Ego Hygiene site.
Structured content is provided through **Astro DB** instead of static JSON files.

## Getting Started

1. Install dependencies from the project root:
   ```bash
   pnpm install
   ```
2. Start the development server:
   ```bash
   pnpm dev
   ```

## Quality checks

Run the following commands to maintain code quality:

```bash
pnpm lint      # run ESLint
pnpm format    # check Prettier formatting
pnpm typecheck # verify TypeScript types
```

Before seeding the database, validate the structured content:
```bash
pnpm validate-data
```
Then run the Astro DB seed command:
```bash
pnpm astro db seed
```

All workspace commands proxy to the `egohygiene.io` package under the hood.
Run `pnpm astro -- <command>` to invoke any Astro CLI commands.
