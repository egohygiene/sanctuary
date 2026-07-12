import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import path from 'node:path';
import { visualizer } from 'rollup-plugin-visualizer';
import react from '@astrojs/react';
import db from '@astrojs/db';
import { remarkModifiedTime, remarkReadingTime } from '@egohygiene/plugins';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

import tailwindcss from '@tailwindcss/vite';

// ESM-compatible __dirname emulation
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export default defineConfig({
  site: 'https://egohygiene.io',
  base: '/',
  integrations: [mdx(), sitemap(), react(), db()],
  publicDir: path.resolve('./public'),
  trailingSlash: 'ignore',
  vite: {
    resolve: {
      alias: {
        '@egohygiene': path.resolve(__dirname, 'src'),
      },
    },
    plugins: [visualizer({
      emitFile: true,
      filename: 'stats.html',
    }), tailwindcss()],
  },
  markdown: {
    remarkPlugins: [remarkModifiedTime, remarkReadingTime],
  },
});
