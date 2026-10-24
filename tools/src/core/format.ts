// Terminal output: color only on a TTY without NO_COLOR.
const useColor = process.stdout.isTTY && !process.env.NO_COLOR;
const paint = (code: number) => (s: string) => (useColor ? `\x1b[${code}m${s}\x1b[0m` : s);
export const green = paint(32);
export const red = paint(31);
export const yellow = paint(33);
export const dim = paint(2);
export const bold = paint(1);

const STATUS_COLOR: Record<string, (s: string) => string> = {
  done: green,
  passing: green,
  pass: green,
  failing: red,
  fail: red,
  error: red,
  stale: yellow,
  started: (s) => s,
  available: dim,
  locked: dim,
  orphan: yellow,
};

export function colorStatus(status: string, text = status): string {
  return (STATUS_COLOR[status] ?? ((s: string) => s))(text);
}

const ANSI = /\x1b\[[0-9;]*m/g;
const width = (s: string) => s.replace(ANSI, '').length;

/** Left-aligned columns separated by two spaces. */
export function table(rows: string[][], indent = ''): string {
  const widths: number[] = [];
  for (const row of rows) row.forEach((cell, i) => (widths[i] = Math.max(widths[i] ?? 0, width(cell))));
  return rows
    .map((row) => indent + row.map((cell, i) => (i === row.length - 1 ? cell : cell + ' '.repeat(widths[i]! - width(cell)))).join('  ').trimEnd())
    .join('\n');
}
