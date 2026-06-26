#!/usr/bin/env bash
# Create Ego Hygiene Schema Ecosystem
# Place this in project root and run: ./init-schema-ecosystem.sh

set -euo pipefail

SCHEMA_DIR="src/data/schemas"
mkdir -p "$SCHEMA_DIR"

write_file() {
  local path="$1"
  local content="$2"
  if [[ ! -f "$path" ]]; then
    echo "$content" > "$path"
    echo "✅ Created: $path"
  else
    echo "⚠️  Skipped (already exists): $path"
  fi
}

# ------------------------
# pillars.schema.json
# ------------------------
write_file "$SCHEMA_DIR/pillars.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Ego Hygiene Pillars",
  "type": "array",
  "items": {
    "type": "object",
    "required": ["id", "slug", "title", "subtitle", "description", "domains", "aspects", "tags", "quote"],
    "properties": {
      "id": { "type": "integer" },
      "slug": { "type": "string" },
      "title": { "type": "string" },
      "subtitle": { "type": "string" },
      "description": { "type": "string" },
      "domains": {
        "type": "array",
        "items": { "type": "string" }
      },
      "aspects": {
        "type": "array",
        "items": { "type": "string" }
      },
      "tags": {
        "type": "array",
        "items": { "type": "string" }
      },
      "quote": { "type": "string" },
      "image": { "type": "string" }
    }
  }
}'

# ------------------------
# synapse.schema.json
# ------------------------
write_file "$SCHEMA_DIR/synapse.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Synapse Entry",
  "type": "object",
  "required": ["id", "slug", "title", "content", "tags", "pillar", "created"],
  "properties": {
    "id": { "type": "string" },
    "slug": { "type": "string" },
    "title": { "type": "string" },
    "content": { "type": "string" },
    "tags": {
      "type": "array",
      "items": { "type": "string" }
    },
    "pillar": { "type": "string" },
    "created": { "type": "string", "format": "date-time" },
    "updated": { "type": "string", "format": "date-time" }
  }
}'

# ------------------------
# terms.schema.json
# ------------------------
write_file "$SCHEMA_DIR/terms.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Glossary Term",
  "type": "object",
  "required": ["id", "slug", "term", "definition"],
  "properties": {
    "id": { "type": "string" },
    "slug": { "type": "string" },
    "term": { "type": "string" },
    "definition": { "type": "string" }
  }
}'

# ------------------------
# tags.schema.json
# ------------------------
write_file "$SCHEMA_DIR/tags.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Tags",
  "type": "array",
  "items": {
    "type": "object",
    "required": ["name", "description"],
    "properties": {
      "name": { "type": "string" },
      "description": { "type": "string" },
      "related": {
        "type": "array",
        "items": { "type": "string" }
      }
    }
  }
}'

# ------------------------
# systems.schema.json
# ------------------------
write_file "$SCHEMA_DIR/systems.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Life Systems",
  "type": "array",
  "items": {
    "type": "object",
    "required": ["name", "description", "pillar", "components"],
    "properties": {
      "name": { "type": "string" },
      "description": { "type": "string" },
      "pillar": { "type": "string" },
      "components": {
        "type": "array",
        "items": { "type": "string" }
      }
    }
  }
}'

# ------------------------
# relationships.schema.json
# ------------------------
write_file "$SCHEMA_DIR/relationships.schema.json" '{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Entity Relationships",
  "type": "array",
  "items": {
    "type": "object",
    "required": ["from", "to", "type", "description"],
    "properties": {
      "from": { "type": "string" },
      "to": { "type": "string" },
      "type": { "type": "string" },
      "description": { "type": "string" }
    }
  }
}'

# ------------------------
# manifest.json
# ------------------------
write_file "$SCHEMA_DIR/manifest.json" '{
  "version": "1.0.0",
  "modules": [
    { "name": "pillars", "file": "pillars.schema.json" },
    { "name": "synapse", "file": "synapse.schema.json" },
    { "name": "terms", "file": "terms.schema.json" },
    { "name": "tags", "file": "tags.schema.json" },
    { "name": "systems", "file": "systems.schema.json" },
    { "name": "relationships", "file": "relationships.schema.json" }
  ]
}'

# ------------------------
# ontology.json
# ------------------------
write_file "$SCHEMA_DIR/ontology.json" '{
  "name": "Ego Hygiene Ontology",
  "version": "1.0.0",
  "entities": [
    { "type": "pillar", "schema": "pillars.schema.json" },
    { "type": "synapse", "schema": "synapse.schema.json" },
    { "type": "term", "schema": "terms.schema.json" },
    { "type": "tag", "schema": "tags.schema.json" },
    { "type": "system", "schema": "systems.schema.json" }
  ],
  "relationships": [
    { "from": "synapse", "to": "pillar", "type": "belongs_to" },
    { "from": "pillar", "to": "tag", "type": "contains" },
    { "from": "system", "to": "pillar", "type": "supports" },
    { "from": "synapse", "to": "tag", "type": "references" }
  ]
}'
