import { db, Term as TermTable } from 'astro:db';

export type Term = {
  id: string;
  slug: string;
  term: string;
  definition: string;
}

export async function loadTerms(): Promise<Term[]> {
  const rows = await db.select().from(TermTable).all();
  const data = rows as unknown[];
  return data.filter((item) => validateTerm(item)) as Term[];
}

export async function mapTermsBySlug(): Promise<Record<string, Term>> {
  const ts = await loadTerms();
  return ts.reduce((acc, t) => {
    acc[t.slug] = t;
    return acc;
  }, {} as Record<string, Term>);
}

function validateTerm(item: any): item is Term {
  if (typeof item !== 'object' || item === null) return false;
  const required = ['id', 'slug', 'term', 'definition'];
  for (const key of required) {
    if (!(key in item)) return false;
  }
  return true;
}
