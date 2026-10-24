// The dashboard's Markdown subset, for the concept pages.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { inline, markdown } from '../src/dashboard/markdown.ts';

test('inline markup escapes everything, and leaves code spans alone', () => {
  assert.equal(inline('a <b> & `x <*y*>` **bold** *em* _em_ [docs](https://example.com)'), 'a &lt;b&gt; &amp; <code>x &lt;*y*&gt;</code> <strong>bold</strong> <em>em</em> <em>em</em> <a href="https://example.com" target="_blank" rel="noopener">docs</a>');
  assert.equal(inline('snake_case_name and 2*3*4'), 'snake_case_name and 2*3*4');
  assert.equal(inline('[x](javascript:alert(1))'), '[x](javascript:alert(1))');
});

test('blocks: headings shifted, paragraphs, lists, fenced code and pipe tables', () => {
  const html = markdown(['# Title', '', 'one', 'two', '', '- a', '- `b`', '', '1. first', '2. second', '', '```koka', 'fun f() <x>', '```', '', '| op | meaning |', '| --- | --- |', '| `\\|>` | pipe |'].join('\n'), 2);
  assert.equal(
    html,
    [
      '<h3>Title</h3>',
      '<p>one two</p>',
      '<ul><li>a</li><li><code>b</code></li></ul>',
      '<ol><li>first</li><li>second</li></ol>',
      '<pre class="code" data-lang="koka">fun f() &lt;x&gt;</pre>',
      '<table class="md"><thead><tr><th>op</th><th>meaning</th></tr></thead><tbody><tr><td><code>|&gt;</code></td><td>pipe</td></tr></tbody></table>',
    ].join('\n'),
  );
});

test('links by reference, collapsed and shortcut, and images as links; definitions vanish, other URLs stay text', () => {
  const html = markdown(['[Darts][darts] at a [target][] or [the board].', '', '![The board][img] and [nothing][missing]', '', '[darts]: https://example.com/darts', '[target]: https://example.com/target "title"', '[the board]: <https://example.com/board>', '[img]: https://example.com/board.svg', '[local]: ./file.md'].join('\n'));
  assert.equal(
    html,
    [
      '<p><a href="https://example.com/darts" target="_blank" rel="noopener">Darts</a> at a <a href="https://example.com/target" target="_blank" rel="noopener">target</a> or <a href="https://example.com/board" target="_blank" rel="noopener">the board</a>.</p>',
      '<p><a href="https://example.com/board.svg" target="_blank" rel="noopener">image: The board</a> and [nothing][missing]</p>',
    ].join('\n'),
  );
});

test("Exercism's admonitions are Markdown in a box, with the document's link references and code inside", () => {
  const html = markdown(['~~~~exercism/note', '_Degenerate triangles_ are **not** tested; see [the spec].', '', '- one', '', '```bqn', 'a ← 1', '```', '~~~~', '', '~~~~exercism/caution', 'Careful.', '~~~~', '', '[the spec]: https://example.com/spec'].join('\n'), 2);
  assert.equal(
    html,
    [
      '<aside class="admonition note"><p class="admonition-title">Note</p><p><em>Degenerate triangles</em> are <strong>not</strong> tested; see <a href="https://example.com/spec" target="_blank" rel="noopener">the spec</a>.</p>',
      '<ul><li>one</li></ul>',
      '<pre class="code" data-lang="bqn">a ← 1</pre></aside>',
      '<aside class="admonition caution"><p class="admonition-title">Caution</p><p>Careful.</p></aside>',
    ].join('\n'),
  );
});
