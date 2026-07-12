import { db } from 'astro:db';
import { Pillar, Synapse, Tag, Term } from 'astro:db';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

async function loadJSON<T>(name: string): Promise<T> {
  const file = join(process.cwd(), 'src', 'data', name);
  const data = await readFile(file, 'utf-8');
  return JSON.parse(data) as T;
}

// https://astro.build/db/seed
export default async function seed() {
  const pillars = await loadJSON<any[]>('pillars.json');
  for (const p of pillars) {
    await db.insert(Pillar).values({
      id: p.id,
      slug: p.slug,
      title: p.title,
      subtitle: p.subtitle,
      description: p.description,
      domains: p.domains,
      aspects: p.aspects,
      tags: p.tags,
      quote: p.quote,
      image: p.image,
    });
  }

  const tags = await loadJSON<any[]>('tags.json');
  for (const t of tags) {
    await db.insert(Tag).values({
      name: t.name,
      description: t.description,
      related: t.related ?? [],
    });
  }

  const terms = await loadJSON<any[]>('terms.json');
  for (const t of terms) {
    await db.insert(Term).values({
      id: t.id,
      slug: t.slug,
      term: t.term,
      definition: t.definition,
    });
  }

  const synapses = await loadJSON<any[]>('synapses.json');
  for (const s of synapses) {
    await db.insert(Synapse).values({
      id: s.id,
      slug: s.slug,
      title: s.title,
      content: s.content,
      tags: s.tags,
      pillarSlug: s.pillarSlug,
      created: new Date(s.created),
      updated: s.updated ? new Date(s.updated) : undefined,
    });
  }
}
