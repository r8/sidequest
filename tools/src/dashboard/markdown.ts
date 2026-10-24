// markdown(): the subset of Markdown the tracks' docs use, as HTML — headings, paragraphs, lists, fenced
// code, Exercism's admonitions (a `~~~~exercism/note` fence, rendered as Markdown in a box), pipe
// tables, inline code, bold, italic, and links, inline or by reference ([text][ref] with a
// `[ref]: url` line). Everything is escaped first; nothing in the source becomes markup unless this subset
// makes it so. Only http(s) links are links, and an image becomes a link to it: the page loads nothing.

const esc = (s: string) => s.replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]!);

const link = (label: string, url: string, image: boolean) => `<a href="${url}" target="_blank" rel="noopener">${image ? `image: ${label}` : label}</a>`;

/** Inline markup: code spans first, so nothing inside them is touched. `refs` holds the `[ref]: url` lines, by lower-case ref. */
export function inline(text: string, refs: Map<string, string> = new Map()): string {
  const spans: string[] = [];
  const held = text.replace(/(`+)([\s\S]*?[^`])\1(?!`)/g, (_, _ticks: string, code: string) => `\u0000${spans.push(`<code>${esc(code.trim())}</code>`) - 1}\u0000`);
  const ref = (key: string) => refs.get(key.toLowerCase());
  return esc(held)
    .replace(/(!?)\[([^\]]+)\]\((https?:\/\/[^)\s]+)\)/g, (_, bang: string, label: string, url: string) => link(label, url, !!bang))
    .replace(/(!?)\[([^\]]+)\]\[([^\]]*)\]/g, (all: string, bang: string, label: string, key: string) => {
      const url = ref(key || label);
      return url ? link(label, url, !!bang) : all;
    })
    .replace(/(!?)\[([^\]]+)\](?![(\[:<])/g, (all: string, bang: string, label: string) => {
      const url = ref(label);
      return url ? link(label, url, !!bang) : all;
    })
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/(^|[^\w*])\*([^*\s][^*]*)\*(?!\w)/g, '$1<em>$2</em>')
    .replace(/(^|[^\w])_([^_\s][^_]*)_(?!\w)/g, '$1<em>$2</em>')
    .replace(/\u0000(\d+)\u0000/g, (_, i: string) => spans[Number(i)]!);
}

const DEFINITION = /^\s{0,3}\[([^\]]+)\]:\s*<?(\S+?)>?(?:\s+["'(].*["')])?\s*$/;

const ADMONITIONS: Record<string, string> = { note: 'Note', caution: 'Caution', warning: 'Warning', advanced: 'Advanced', tip: 'Tip', success: 'Success' };

/** `shift` pushes headings down, so a document's `#` fits under the page's own headings. */
export function markdown(source: string, shift = 0): string {
  const refs = new Map<string, string>();
  const lines = source
    .replace(/\r\n/g, '\n')
    .split('\n')
    .filter((line) => {
      const def = DEFINITION.exec(line);
      if (!def) return true;
      if (/^https?:\/\//.test(def[2]!)) refs.set(def[1]!.toLowerCase(), esc(def[2]!));
      return false;
    });
  return blocks(lines, shift, refs);
}

/** The blocks of `lines`; an admonition's body is blocks too, with the document's link references. */
function blocks(lines: string[], shift: number, refs: Map<string, string>): string {
  const inline_ = (text: string) => inline(text, refs);
  const cells = (row: string) => row.trim().replace(/^\||\|$/g, '').split(/(?<!\\)\|/).map((c) => inline_(c.trim().replace(/\\\|/g, '|')));
  const out: string[] = [];
  let para: string[] = [];
  const flush = () => {
    if (para.length) out.push(`<p>${inline_(para.join(' '))}</p>`);
    para = [];
  };
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i]!;
    const fence = /^(\s*)(`{3,}|~{3,})\s*([\w+/-]*)/.exec(line);
    if (fence) {
      flush();
      const body: string[] = [];
      for (i++; i < lines.length && !lines[i]!.trimStart().startsWith(fence[2]!); i++) body.push(lines[i]!);
      const kind = /^exercism\/(\w+)$/.exec(fence[3]!)?.[1];
      if (kind && ADMONITIONS[kind]) {
        out.push(`<aside class="admonition ${kind}"><p class="admonition-title">${ADMONITIONS[kind]}</p>${blocks(body, shift, refs)}</aside>`);
        continue;
      }
      out.push(`<pre class="code"${fence[3] ? ` data-lang="${esc(fence[3])}"` : ''}>${esc(body.join('\n'))}</pre>`);
      continue;
    }
    const heading = /^(#{1,6})\s+(.*)$/.exec(line);
    if (heading) {
      flush();
      const level = Math.min(6, heading[1]!.length + shift);
      out.push(`<h${level}>${inline_(heading[2]!)}</h${level}>`);
      continue;
    }
    if (/^\s*\|/.test(line) && /^\s*\|?\s*:?-{2,}/.test(lines[i + 1] ?? '')) {
      flush();
      const head = cells(line);
      const rows: string[][] = [];
      for (i += 2; i < lines.length && /^\s*\|/.test(lines[i]!); i++) rows.push(cells(lines[i]!));
      i--;
      out.push(`<table class="md"><thead><tr>${head.map((c) => `<th>${c}</th>`).join('')}</tr></thead><tbody>${rows.map((r) => `<tr>${r.map((c) => `<td>${c}</td>`).join('')}</tr>`).join('')}</tbody></table>`);
      continue;
    }
    const item = /^\s*([-*]|\d+\.)\s+(.*)$/.exec(line);
    if (item) {
      flush();
      const ordered = /\d/.test(item[1]!);
      const items: string[] = [];
      for (; i < lines.length; i++) {
        const m = /^\s*([-*]|\d+\.)\s+(.*)$/.exec(lines[i]!);
        if (m && /\d/.test(m[1]!) === ordered) items.push(m[2]!);
        else if (items.length && /^\s{2,}\S/.test(lines[i]!)) items[items.length - 1] += ` ${lines[i]!.trim()}`;
        else break;
      }
      i--;
      const tag = ordered ? 'ol' : 'ul';
      out.push(`<${tag}>${items.map((t) => `<li>${inline_(t)}</li>`).join('')}</${tag}>`);
      continue;
    }
    if (!line.trim()) flush();
    else para.push(line.trim());
  }
  flush();
  return out.join('\n');
}
