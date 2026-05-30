import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightThemeRapide from 'starlight-theme-rapide';

export default defineConfig({
  site: 'https://ilyeshdz.github.io',
  base: '/tinycord',
  integrations: [
    starlight({
      plugins: [starlightThemeRapide()],
      title: 'Tinycord',
      social: [
        { icon: 'github', label: 'GitHub', href: 'https://github.com/ilyeshdz/tinycord' },
      ],
      sidebar: [
        {
          label: 'Download',
          slug: 'download',
        },
        {
          label: 'Guides',
          items: [
            { label: 'Getting Started', slug: 'guides/example' },
          ],
        },
        {
          label: 'Reference',
          items: [
            { label: 'Architecture', slug: 'reference/example' },
          ],
        },
      ],
    }),
  ],
});
