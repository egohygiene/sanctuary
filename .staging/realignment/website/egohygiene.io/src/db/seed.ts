import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import db from './db';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const seedPath = join(__dirname, 'seed.json');
const data = JSON.parse(readFileSync(seedPath, 'utf-8')) as any[];

const insert = db.prepare(
  'INSERT INTO synapses (title, slug, content, tags, visual_asset_url) VALUES (?, ?, ?, ?, ?)',
);

const run = db.transaction((rows: any[]) => {
  for (const row of rows) {
    insert.run(row.title, row.slug, row.content, row.tags, row.visual_asset_url);
  }
});

run(data);

console.log(`Seeded ${data.length} synapses`);
