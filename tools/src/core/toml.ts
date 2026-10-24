// Just enough TOML for mise.toml's [tools] keys and Exercism's tests.toml: tables, string / boolean /
// number values. Anything else (arrays, inline tables) is kept as its raw source text.
export type TomlValue = string | number | boolean;
export type TomlDoc = Map<string, Map<string, TomlValue>>;

function unquote(text: string): string {
  if (text.startsWith("'")) return text.slice(1, -1);
  return JSON.parse(text) as string;
}

function parseValue(raw: string): TomlValue {
  const v = raw.trim();
  if (v === 'true') return true;
  if (v === 'false') return false;
  if (/^"(?:[^"\\]|\\.)*"$/.test(v) || /^'[^']*'$/.test(v)) return unquote(v);
  if (/^[+-]?\d[\d_]*(\.\d+)?$/.test(v)) return Number(v.replace(/_/g, ''));
  return v;
}

/** Strips a trailing comment that is not inside a string. */
function stripComment(line: string): string {
  let quote: string | null = null;
  for (let i = 0; i < line.length; i++) {
    const c = line[i];
    if (quote) {
      if (c === '\\' && quote === '"') i++;
      else if (c === quote) quote = null;
    } else if (c === '"' || c === "'") quote = c;
    else if (c === '#') return line.slice(0, i);
  }
  return line;
}

function parseKey(raw: string): string {
  const k = raw.trim();
  return k.startsWith('"') || k.startsWith("'") ? unquote(k) : k;
}

export function parseToml(text: string): TomlDoc {
  const doc: TomlDoc = new Map([['', new Map()]]);
  let current = doc.get('')!;
  for (const rawLine of text.split('\n')) {
    const line = stripComment(rawLine).trim();
    if (!line) continue;
    const table = /^\[\[?\s*(.+?)\s*\]\]?$/.exec(line);
    if (table) {
      const name = parseKey(table[1]!);
      current = doc.get(name) ?? new Map();
      doc.set(name, current);
      continue;
    }
    const eq = /^((?:"(?:[^"\\]|\\.)*"|'[^']*'|[A-Za-z0-9_.:\/-]+))\s*=\s*(.*)$/.exec(line);
    if (eq) current.set(parseKey(eq[1]!), parseValue(eq[2]!));
  }
  return doc;
}
