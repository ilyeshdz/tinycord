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
          'line-height': '1.15',
        },
        h1: { 'font-size': '2em', 'margin': '0 0 0' },
        h2: { 'font-size': '1.5em', 'margin': '1em 0 0.35em' },
        h3: { 'font-size': '1.125em', 'margin': '0.75em 0 0.35em' },
        a: {
          'text-underline-offset': '2px',
        },
        'a code': {
          color: 'inherit',
          'font-weight': 'inherit',
        },
        'ol > li::marker': { color: '#94a3b8' },
        'ul > li::marker': { color: '#94a3b8' },
        'code::before': { content: '""' },
        'code::after': { content: '""' },
        code: {
          'font-size': '0.85em',
          'font-weight': '500',
          'background': '#1e293b',
          'padding': '0.2em 0.4em',
        },
      },
    }),
  ],
  shortcuts: {
    'text-accent': 'text-[#2dd4bf]',
    'bg-accent': 'bg-[#2dd4bf]',
    'bg-surface': 'bg-[#0b1120]',
    'bg-muted': 'bg-[#131e33]',
    'border-default': 'border-[#1e2d45]',
    'text-primary': 'text-[#e2e8f0]',
    'text-secondary': 'text-[#94a3b8]',
    'text-tertiary': 'text-[#475569]',
    'btn-primary': 'inline-flex h-9 items-center gap-2 border border-[#2dd4bf] bg-[#2dd4bf] px-4 text-sm font-medium text-[#0b1120] no-underline hover:opacity-80 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#2dd4bf]',
    'btn-secondary': 'inline-flex h-9 items-center gap-2 border border-default bg-transparent px-4 text-sm font-medium text-primary no-underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[#2dd4bf]',
  },
})
