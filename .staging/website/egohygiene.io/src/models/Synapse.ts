import { db, Synapse as SynapseTable } from 'astro:db';

export type Synapse = {
  id: string;
  slug: string;
  title: string;
  content: string;
  tags: string[];
  pillarSlug: string;
  created: Date;
  updated?: Date;
}

export async function loadSynapses(): Promise<Synapse[]> {
  const rows = await db.select().from(SynapseTable).all();
  return rows.map((r) => r as Synapse);
}

/**
 * Historically this loader was exposed as `getSynapses` in various parts of the
 * codebase. Provide a thin wrapper so both names can be used interchangeably.
 */
export function getSynapses(): Promise<Synapse[]> {
  return loadSynapses();
}

export async function mapSynapsesBySlug(): Promise<Record<string, Synapse>> {
  const syns = await loadSynapses();
  return syns.reduce((acc, item) => {
    acc[item.slug] = item;
    return acc;
  }, {} as Record<string, Synapse>);
}

function validateSynapse(item: any): item is Synapse {
  if (typeof item !== 'object' || item === null) return false;
  const required = ['id', 'slug', 'title', 'content', 'tags', 'pillarSlug', 'created'];
  for (const key of required) {
    if (!(key in item)) return false;
  }
  if (!Array.isArray(item.tags)) return false;
  if (isNaN(Date.parse(item.created))) return false;
  if (item.updated && isNaN(Date.parse(item.updated))) return false;
  return true;
}
