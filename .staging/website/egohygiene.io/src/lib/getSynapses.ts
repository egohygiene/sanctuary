import db from '../db/db';

export interface SynapseRow {
  id: number;
  title: string;
  slug: string;
  content: string;
  tags: string | null;
  created_at: string;
  updated_at: string;
  visual_asset_url: string | null;
}

export function getSynapses(): SynapseRow[] {
  const stmt = db.prepare('SELECT * FROM synapses ORDER BY created_at DESC');
  return stmt.all() as SynapseRow[];
}
