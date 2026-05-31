// @ts-check

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import UnoCSS from '@unocss/astro';
import { defineConfig, fontProviders } from 'astro/config';

export default defineConfig({
	site: process.env.ASTRO_SITE_URL || 'https://tinycord.app',
	base: process.env.ASTRO_BASE || '/',
	integrations: [mdx(), sitemap(), UnoCSS({ injectReset: true })],
	fonts: [
		{
			provider: fontProviders.fontshare(),
			cssVariable: "--font-general-sans",
			name: "General Sans",
			weights: [400, 500, 600, 700]
		}
	]
});
