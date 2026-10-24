// Exercism's file-name placeholders.
export function expandTemplate(template: string, slug: string): string {
  const words = slug.split('-').filter(Boolean);
  const cap = (w: string) => w.charAt(0).toUpperCase() + w.slice(1);
  return template
    .replaceAll('%{kebab_slug}', words.join('-'))
    .replaceAll('%{snake_slug}', words.join('_'))
    .replaceAll('%{camel_slug}', words.map((w, i) => (i === 0 ? w : cap(w))).join(''))
    .replaceAll('%{pascal_slug}', words.map(cap).join(''));
}
