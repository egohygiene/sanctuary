import relationships from '@egohygiene/data/relationships.json';

export type Relationship = {
  from: string;
  to: string;
  type: string;
  description: string;
}

export function loadRelationships(): Relationship[] {
  return relationships as Relationship[];
}

export function mapRelationshipsByFrom(): Record<string, Relationship[]> {
  return loadRelationships().reduce((acc, rel) => {
    if (!acc[rel.from]) acc[rel.from] = [];
    acc[rel.from].push(rel);
    return acc;
  }, {} as Record<string, Relationship[]>);
}
