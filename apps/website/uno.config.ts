import {
  defineConfig,
  presetUno,
  presetAttributify,
  presetTypography,
} from 'unocss'

export default defineConfig({
  presets: [
    presetUno(),
    presetAttributify(),
    presetTypography({
      cssExtend: {
        'h1,h2,h3,h4': {
          'font-weight': '700',
          'line-height': '1.3',
        },
        h1: { 'font-size': '2em', 'margin': '0 0 0.5em' },
        h2: { 'font-size': '1.5em', 'margin': '1.5em 0 0.5em' },
        h3: { 'font-size': '1.125em', 'margin': '1.25em 0 0.5em' },
        a: {
          'text-underline-offset': '2px',
        },
        'a code': {
          color: 'inherit',
        },
        'ol > li::marker': {
          color: '#94a3b8',
        },
        'ul > li::marker': {
          color: '#94a3b8',
        },
      },
    }),
  ],
  dark: 'class',
  shortcuts: {
    'text-accent': 'text-[#0d9488] dark:text-[#2dd4bf]',
    'bg-accent': 'bg-[#0d9488] dark:bg-[#2dd4bf]',
    'bg-surface': 'bg-white dark:bg-[#0f172a]',
    'bg-muted': 'bg-[#f8fafc] dark:bg-[#1e293b]',
    'border-default': 'border-[#e2e8f0] dark:border-[#334155]',
    'text-primary': 'text-[#1e293b] dark:text-[#f1f5f9]',
    'text-secondary': 'text-[#64748b] dark:text-[#94a3b8]',
    'text-tertiary': 'text-[#94a3b8] dark:text-[#64748b]',
  },
})
