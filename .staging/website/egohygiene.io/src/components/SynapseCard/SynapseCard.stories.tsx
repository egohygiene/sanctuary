import type { Meta, StoryObj } from '@storybook/react';
import SynapseCard from './SynapseCard.astro';
import type { SynapseCardProps } from './SynapseCard.types';

const meta: Meta<SynapseCardProps> = {
  title: 'Components/SynapseCard',
  component: SynapseCard,
};

export default meta;

export const Default: StoryObj<SynapseCardProps> = {
  args: {
    synapse: {
      id: '1',
      slug: 'test',
      title: 'Test Title',
      content: 'Test content',
      tags: ['tag'],
      pillarSlug: 'pillar',
      created: new Date(),
    },
  },
};
