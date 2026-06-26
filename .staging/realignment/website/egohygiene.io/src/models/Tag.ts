import { db, Tag as TagTable } from 'astro:db';

export type Tag = {
  name: string;
  description: string;
  related?: string[];
}

export async function loadTags(): Promise<Tag[]> {
  const rows = await db.select().from(TagTable).all();
  return rows as Tag[];
}

export async function mapTagsByName(): Promise<Record<string, Tag>> {
  const tags = await loadTags();
  return tags.reduce((acc, tag) => {
    acc[tag.name] = tag;
    return acc;
  }, {} as Record<string, Tag>);
}
