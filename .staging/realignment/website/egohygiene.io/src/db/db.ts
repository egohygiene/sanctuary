import Database from 'better-sqlite3';
import { join } from 'path';
import { readFileSync } from 'fs';

const dbPath = join(process.cwd(), 'synapses.db');
const db = new Database(dbPath);

const schema = readFileSync(new URL('./schema.sql', import.meta.url), 'utf-8');
db.exec(schema);

export default db;
