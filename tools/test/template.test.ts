import { test } from 'node:test';
import assert from 'node:assert/strict';
import { expandTemplate } from '../src/core/template.ts';

test('expandTemplate implements all four Exercism placeholders', () => {
  assert.equal(expandTemplate('%{kebab_slug}.janet', 'two-fer'), 'two-fer.janet');
  assert.equal(expandTemplate('src/%{snake_slug}.inko', 'two-fer'), 'src/two_fer.inko');
  assert.equal(expandTemplate('%{camel_slug}', 'reverse-string-now'), 'reverseStringNow');
  assert.equal(expandTemplate('%{pascal_slug}.kk', 'two-fer'), 'TwoFer.kk');
});
