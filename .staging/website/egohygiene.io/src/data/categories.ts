export interface Category {
  name: string;
  slug: string;
  image: string;
}

export interface CategoryGroup {
  group: string;
  categories: Category[];
}

const makeSlug = (name: string) => name.toLowerCase().replace(/\s+/g, '-');

export const CATEGORY_GROUPS: CategoryGroup[] = [
  {
    group: 'Mental & Cognitive',
    categories: [
      'psychology',
      'neurology',
      'cognitive science',
      'behavioral science',
      'identity',
      'habit formation',
      'self-discipline',
    ].map((name) => ({
      name,
      slug: makeSlug(name),
      image: `/assets/categories/${makeSlug(name)}.jpg`,
    })),
  },
  {
    group: 'Spiritual & Transpersonal',
    categories: [
      'spirituality',
      'metaphysics',
      'consciousness studies',
      'shadow work',
      'archetypes',
      'ritual',
      'alchemy',
      'dreamwork',
    ].map((name) => ({
      name,
      slug: makeSlug(name),
      image: `/assets/categories/${makeSlug(name)}.jpg`,
    })),
  },
  {
    group: 'Body & Embodiment',
    categories: [
      'meditation',
      'breathwork',
      'somatics',
      'healing',
    ].map((name) => ({
      name,
      slug: makeSlug(name),
      image: `/assets/categories/${makeSlug(name)}.jpg`,
    })),
  },
  {
    group: 'Philosophical & Reflective',
    categories: [
      'philosophy',
      'existentialism',
      'ethics',
      'symbolism',
      'journaling',
      'downloads',
      'synapse',
    ].map((name) => ({
      name,
      slug: makeSlug(name),
      image: `/assets/categories/${makeSlug(name)}.jpg`,
    })),
  },
  {
    group: 'Systems & External',
    categories: [
      'systems thinking',
      'technology',
      'information theory',
    ].map((name) => ({
      name,
      slug: makeSlug(name),
      image: `/assets/categories/${makeSlug(name)}.jpg`,
    })),
  },
];
