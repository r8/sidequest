// Track colours (quest.json "color"): eighteen of equal lightness and chroma (OKLCH 0.6 / 0.16, hues 20°
// apart), in the order tracks take them. Each is far from the one before it; the greens and the red, which
// read as done and failing on the dashboard, come last.
export const PALETTE = [
  '#9763cc', // purple
  '#03919d', // cyan
  '#cb5a1a', // orange
  '#c05296', // pink
  '#0486d3', // blue
  '#8c8305', // mustard
  '#796eda', // violet
  '#cb4f73', // rose
  '#0b9488', // teal
  '#b66c02', // amber
  '#ae59b4', // orchid
  '#098db2', // ocean
  '#6c8e03', // olive
  '#507adf', // indigo
  '#a17904', // ochre
  '#31983d', // green
  '#ce514d', // red
  '#01976d', // jade
];

/**
 * The colour new-track gives a track, given the other tracks' colours: the first in the palette that none
 * uses, and once all are, round again — the one fewest use, the earliest of those.
 */
export function nextColor(used: string[]): string {
  const uses = PALETTE.map((c) => used.filter((u) => u.toLowerCase() === c).length);
  return PALETTE[uses.indexOf(Math.min(...uses))]!;
}

/** The colour of a track whose quest.json names none: one from the palette by its slug, so it stays the same. */
export function fallbackColor(slug: string): string {
  let h = 0;
  for (const c of slug) h = (h * 31 + c.charCodeAt(0)) % PALETTE.length;
  return PALETTE[h]!;
}
