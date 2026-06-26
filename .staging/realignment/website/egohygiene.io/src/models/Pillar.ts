import { db, Pillar as PillarTable } from 'astro:db';

export type Pillar = {
  id: number;
  slug: string;
  title: string;
  subtitle: string;
  description: string;
  domains: string[];
  aspects: string[];
  tags: string[];
  quote: string;
  image?: string;
}

export async function loadPillars(): Promise<Pillar[]> {
  const rows = await db.select().from(PillarTable).all();
  return rows as Pillar[];
}

export async function mapPillarsBySlug(): Promise<Record<string, Pillar>> {
  const ps = await loadPillars();
  return ps.reduce((acc, pillar) => {
    acc[pillar.slug] = pillar;
    return acc;
  }, {} as Record<string, Pillar>);
}
