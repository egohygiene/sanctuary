import db from '../db/db';
import type { SynapseRow } from './getSynapses';

export function getSynapseBySlug(slug: string): SynapseRow | undefined {
  const stmt = db.prepare('SELECT * FROM synapses WHERE slug = ?');
  return stmt.get(slug) as SynapseRow | undefined;
}
