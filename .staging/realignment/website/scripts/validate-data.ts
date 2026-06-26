import Ajv from 'ajv';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

const dataDir = join(process.cwd(), 'src', 'data');
const schemaDir = join(dataDir, 'schemas');

const files = [
  ['pillars.json', 'pillars.schema.json'],
  ['synapses.json', 'synapse.schema.json'],
  ['tags.json', 'tags.schema.json'],
  ['terms.json', 'terms.schema.json'],
];

const ajv = new Ajv({ allErrors: true, strict: false });

async function validate() {
  let valid = true;

  for (const [dataFile, schemaFile] of files) {
    const schemaPath = join(schemaDir, schemaFile);
    const dataPath = join(dataDir, dataFile);
    const schema = JSON.parse(await readFile(schemaPath, 'utf-8'));
    const data = JSON.parse(await readFile(dataPath, 'utf-8'));
    const check = ajv.compile(schema);
    const items = Array.isArray(data) ? data : [data];

    for (const item of items) {
      const ok = check(item);
      if (!ok) {
        valid = false;
        console.error(`Validation failed for ${dataFile}`, check.errors);
        break;
      }
    }
  }

  if (valid) {
    console.log('All data files valid.');
  } else {
    process.exitCode = 1;
  }
}

validate();
