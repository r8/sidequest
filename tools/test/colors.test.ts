// Track colours: eighteen in a fixed order; new-track gives out the first unused, round again once all are.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { PALETTE, fallbackColor, nextColor } from '../src/core/colors.ts';

test('the palette holds eighteen distinct colours', () => {
  assert.equal(PALETTE.length, 18);
  assert.equal(new Set(PALETTE).size, 18);
  for (const c of PALETTE) assert.match(c, /^#[0-9a-f]{6}$/);
});

test('a new track takes the first colour no track uses, and once all are used, goes round again', () => {
  assert.equal(nextColor([]), PALETTE[0]);
  assert.equal(nextColor(PALETTE.slice(0, 5)), PALETTE[5]);
  // A deleted track's colour is free again, before the ones after it.
  assert.equal(nextColor([PALETTE[0]!, PALETTE[2]!, PALETTE[3]!.toUpperCase()]), PALETTE[1]);
  // A colour outside the palette takes none of it.
  assert.equal(nextColor(['#123456']), PALETTE[0]);
  // The 19th track gets the first colour again, the 20th the second.
  assert.equal(nextColor(PALETTE), PALETTE[0]);
  assert.equal(nextColor([...PALETTE, PALETTE[0]!]), PALETTE[1]);
});

test('a track without a colour gets one from the palette, the same each time', () => {
  assert.ok(PALETTE.includes(fallbackColor('uiua')));
  assert.equal(fallbackColor('uiua'), fallbackColor('uiua'));
});
