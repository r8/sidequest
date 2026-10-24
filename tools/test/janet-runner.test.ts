// Janet-specific unit tests: test_code extraction and test generation. The run → results.json
// mapping is pinned by the shared golden tests in runners.test.ts.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';
import janet, { extractDeftests, janetLiteral, janetName, unescapeJanetString } from '../src/runners/janet.ts';
import { CanonicalData } from '../src/schema/canonical.ts';
import { ExerciseConfig } from '../src/schema/exercise-config.ts';

test('extractDeftests finds balanced forms and skips strings and comments', () => {
  const src = [
    '# (t/deftest "in a comment" nope)',
    '(t/deftest "a" (t/assert-equal ")" (f "(")))',
    '(deftest "b\\tc" `long ) string` [1 2] {:k (g)})',
    '(do (t/deftest "nested" (h)))',
  ].join('\n');
  const forms = extractDeftests(src);
  assert.deepEqual([...forms.keys()], ['a', 'b\tc', 'nested']);
  assert.equal(forms.get('a'), '(t/deftest "a" (t/assert-equal ")" (f "(")))');
  assert.equal(forms.get('b\tc'), '(deftest "b\\tc" `long ) string` [1 2] {:k (g)})');
});

test('unescapeJanetString handles Janet escapes', () => {
  assert.equal(unescapeJanetString('a\\"b\\\\c\\n\\x41\\u00e9'), 'a"b\\c\nAé');
});

test('generateTests renders canonical data as the committed isogram tests', () => {
  const dir = fileURLToPath(new URL('./fixtures/janet/generate/isogram/', import.meta.url));
  const canonical = CanonicalData.parse(JSON.parse(readFileSync(join(dir, 'canonical-data.json'), 'utf8')));
  const meta = ExerciseConfig.parse(JSON.parse(readFileSync(join(dir, 'meta.json'), 'utf8')));
  const files = janet.generateTests!(canonical, meta);
  assert.deepEqual(Object.keys(files), ['test/isogram.janet']);
  assert.equal(files['test/isogram.janet'], readFileSync(join(dir, 'expected.janet'), 'utf8'));
});

test('janetLiteral and janetName', () => {
  assert.equal(janetLiteral({ a: [1, 'x"\n\\'], b: null, c: true }), '{"a" [1 "x\\"\\n\\\\"] "b" nil "c" true}');
  assert.equal(janetLiteral('\x01'), '"\\x01"');
  assert.equal(janetName('isIsogram'), 'isogram?');
  assert.equal(janetName('findAnagrams'), 'find-anagrams');
  assert.equal(janetName('distance'), 'distance');
});
