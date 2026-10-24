# side Sides table → for each row of the table, a c×c table that is 1 where columns i<j both hold
# '+' and every character between them is '+' or side, so the stretch i…j can be a side
Sides ← {
  plus ← '+' = 𝕩
  ok ← plus ∨ 𝕨 = 𝕩
  plus {(∧⌜˜ 𝕨) ∧ (<⌜˜ ↕≠𝕨) ∧ =⌜˜ +`¬𝕩}˘ ok
}

# Count table → the number of rectangles in a non-empty character table
Count ← {
  h ← '-' Sides 𝕩             # h[r;c1;c2]: row r has a side from column c1 to c2
  v ← '|' Sides ⍉𝕩            # v[c;r1;r2]: column c has a side from row r1 to r2
  hh ← > ∧⌜˜ <⎉2 h            # [r1;r2;c1;c2]: both rows have that side
  vv ← > ∧⌜˜ <⎉2 v            # [c1;c2;r1;r2]: both columns have that side
  +´⥊ hh ∧ 2‿3‿0‿1 ⍉ vv
}

# Rectangles diagram → the number of rectangles drawn in the diagram (a list of row strings) with
# '+' corners, '-' horizontal sides and '|' vertical sides
Rectangles ⇐ {0 = ×´≢>𝕩 ? 0 ; Count >𝕩}
