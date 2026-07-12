import { describe, it, expect } from 'vitest';
import { render } from '@astrojs/test-utils';
import SynapseCard from './SynapseCard.astro';

const mockSynapse = {
  id: '1',
  slug: 'test',
  title: 'Test Title',
  content: 'Test content',
  tags: ['tag'],
  pillarSlug: 'pillar',
  created: new Date(),
};

describe('SynapseCard', () => {
  it('renders the title', async () => {
    const result = await render(SynapseCard, { props: { synapse: mockSynapse } });
    expect(result.container.textContent).toContain(mockSynapse.title);
  });
});
