// @ts-check

import { defineConfig } from 'astro/config';
import icon from 'astro-icon';

export default defineConfig({
  site: process.env.ASTRO_SITE_URL || 'https://ilyeshdz.github.io',
  base: process.env.ASTRO_BASE || '/tinycord/',
  integrations: [icon()],
});
