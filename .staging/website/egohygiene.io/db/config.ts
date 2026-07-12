import { defineDb, defineTable, column } from 'astro:db';

// https://astro.build/db/config
export const Pillar = defineTable({
  columns: {
    id: column.number({ primaryKey: true }),
    slug: column.text({ unique: true }),
    title: column.text(),
    subtitle: column.text(),
    description: column.text(),
    domains: column.json(),
    aspects: column.json(),
    tags: column.json(),
    quote: column.text(),
    image: column.text({ optional: true }),
  },
});

export const Synapse = defineTable({
  columns: {
    id: column.text({ primaryKey: true }),
    slug: column.text({ unique: true }),
    title: column.text(),
    content: column.text(),
    tags: column.json(),
    pillarSlug: column.text(),
    created: column.date(),
    updated: column.date({ optional: true }),
  },
});

export const Tag = defineTable({
  columns: {
    name: column.text({ primaryKey: true }),
    description: column.text(),
    related: column.json({ optional: true }),
  },
});

export const Term = defineTable({
  columns: {
    id: column.text({ primaryKey: true }),
    slug: column.text({ unique: true }),
    term: column.text(),
    definition: column.text(),
  },
});

export default defineDb({
  tables: { Synapse, Pillar, Tag, Term },
});
