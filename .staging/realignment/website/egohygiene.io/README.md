# EgoHygiene Blog

This package contains the Astro frontend for the EgoHygiene blog. The codebase has been modularized so every UI element lives in its own component folder and content is loaded from a SQLite database.

## Project Structure

```
src/
  components/
    SynapseCard/
      SynapseCard.astro
      SynapseCard.types.ts
      SynapseCard.styles.css
      SynapseCard.test.tsx
      SynapseCard.stories.tsx
      index.ts
  db/
    schema.sql
    seed.json
    db.ts
    seed.ts
  lib/
    getSynapses.ts
    getSynapseBySlug.ts
  pages/
    index.astro
    synapse/[slug].astro
```

## Development

Install dependencies and start the dev server:

```sh
pnpm install
pnpm dev
```

### Database

The blog content is stored in a local SQLite database. To create and seed the database with demo content run:

```sh
pnpm dev:db:seed
```

This will generate a `synapses.db` file in the project root using the schema defined in `src/db/schema.sql` and the sample data in `src/db/seed.json`.

## Testing

Vitest and Storybook files are provided for the `SynapseCard` component as examples of the component architecture. Run tests with:

```sh
pnpm test
```

## Adding Synapses

New synapses can be inserted using SQL or by modifying `seed.json` and running the seed script again. Future iterations may include an admin panel for managing content.

