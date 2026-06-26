export interface Synapse {
  id: number;
  title: string;
  slug: string;
  content: string;
  tags: string | null;
  created_at: string;
  updated_at: string;
  visual_asset_url: string | null;
}

export interface SynapseCardProps {
  synapse: Synapse;
}
