# IsIsogram phrase → 1 if no letter repeats, ignoring case, spaces and hyphens, else 0

# BQN has no Unicode tables, so these cover the cased letters of Latin-1, Latin Extended-A, Greek,
# Cyrillic and the fullwidth forms. first‿last‿offset‿step: every step-th character from first to
# last is a capital whose small letter is offset further on.
caseRanges ← ⟨
  'A'‿'Z'‿32‿1, 'À'‿'Ö'‿32‿1, 'Ø'‿'Þ'‿32‿1
  'Ā'‿'Į'‿1‿2, 'İ'‿'İ'‿¯199‿1, 'Ĳ'‿'Ķ'‿1‿2, 'Ĺ'‿'Ň'‿1‿2, 'Ŋ'‿'Ŷ'‿1‿2, 'Ÿ'‿'Ÿ'‿¯121‿1, 'Ź'‿'Ž'‿1‿2
  'Ά'‿'Ά'‿38‿1, 'Έ'‿'Ί'‿37‿1, 'Ό'‿'Ό'‿64‿1, 'Ύ'‿'Ώ'‿63‿1, 'Α'‿'Ρ'‿32‿1, 'Σ'‿'Ϋ'‿32‿1
  'Ѐ'‿'Џ'‿80‿1, 'А'‿'Я'‿32‿1
  'Ａ'‿'Ｚ'‿32‿1
⟩
upper ← ∾ {f‿l‿o‿s: f + s × ↕1+⌊(l-f)÷s}¨ caseRanges
lower ← upper + ∾ {f‿l‿o‿s: o¨ ↕1+⌊(l-f)÷s}¨ caseRanges
letters ← "ß" ∾ lower                       # the small letters, after lowercasing

IsIsogram ⇐ {
  l ← (lower∾𝕩) ⊏˜ (upper∾𝕩) ⊐ 𝕩          # capitals become small letters, the rest stay
  ∧´∊ (l∊letters) / l
}
