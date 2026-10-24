# CalculateFrequencies texts → each letter‿count pair over all the texts, sorted by letter. Letters
# are characters, counted case-insensitively as lowercase; anything that isn't a letter is ignored.
# BQN has no Unicode tables, so these cover the common scripts: case pairs in Latin, Greek, Cyrillic and
# the fullwidth forms; as non-letters, every script's decimal digits, the combining marks of the
# European scripts, Hebrew, Arabic, Devanagari, Thai and kana, and the punctuation and symbol blocks.
# Elsewhere a character is a letter without case.

# first‿last‿offset‿step: every step-th character from first to last lowercases to itself plus offset.
# Sorted by first; the first range (@ to itself) keeps every lookup in bounds.
caseRanges ← ⟨
  @‿@‿0‿1
  'A'‿'Z'‿32‿1
  'À'‿'Ö'‿32‿1, 'Ø'‿'Þ'‿32‿1
  'Ā'‿'Į'‿1‿2, 'İ'‿'İ'‿¯199‿1, 'Ĳ'‿'Ķ'‿1‿2, 'Ĺ'‿'Ň'‿1‿2, 'Ŋ'‿'Ŷ'‿1‿2, 'Ÿ'‿'Ÿ'‿¯121‿1, 'Ź'‿'Ž'‿1‿2
  'Ά'‿'Ά'‿38‿1, 'Έ'‿'Ί'‿37‿1, 'Ό'‿'Ό'‿64‿1, 'Ύ'‿'Ώ'‿63‿1, 'Α'‿'Ρ'‿32‿1, 'Σ'‿'Ϋ'‿32‿1
  'Ѐ'‿'Џ'‿80‿1, 'А'‿'Я'‿32‿1
  'Ａ'‿'Ｚ'‿32‿1
⟩
first‿last‿offset‿step ← <˘ ⍉ > caseRanges
Lower ← {
  i ← 1 -˜ first ⍋ 𝕩
  𝕩 + (i⊏offset) × (𝕩 ≤ i⊏last) ∧ 0 = (i⊏step) | 𝕩 - i⊏first
}

# first‿last of the characters that are not letters, sorted. Uppercase ASCII is gone by the time it is
# used; ª µ º in Latin-1 are letters.
nonLetters ← ⟨
  @‿'@', '['‿'`', '{'‿'©', '«'‿'´', '¶'‿'¹', '»'‿'¿', '×'‿'×', '÷'‿'÷'
  (@+768)‿(@+879), (@+894)‿(@+894), (@+903)‿(@+903)   # combining marks, Greek ; and ·
  (@+1155)‿(@+1161)                          # Cyrillic combining marks
  (@+1425)‿(@+1469), (@+1471)‿(@+1471), (@+1473)‿(@+1474), (@+1476)‿(@+1477), (@+1479)‿(@+1479)   # Hebrew points
  (@+1552)‿(@+1562), (@+1611)‿(@+1631), (@+1648)‿(@+1648)   # Arabic marks
  (@+1750)‿(@+1756), (@+1759)‿(@+1764), (@+1767)‿(@+1768), (@+1770)‿(@+1773)
  (@+2304)‿(@+2307), (@+2362)‿(@+2364), (@+2366)‿(@+2383), (@+2385)‿(@+2391), (@+2402)‿(@+2403)   # Devanagari signs
  (@+3633)‿(@+3633), (@+3636)‿(@+3642), (@+3655)‿(@+3662)   # Thai vowel and tone marks
  (@+6832)‿(@+6862), (@+7616)‿(@+7679)       # more combining marks
  (@+8192)‿(@+11263), (@+11776)‿(@+11903)    # punctuation, symbols, arrows, dingbats …
  (@+12288)‿(@+12292), (@+12295)‿(@+12351)   # CJK punctuation (々 and 〆 are letters)
  (@+12441)‿(@+12444)                        # kana voicing marks
  (@+65024)‿(@+65135), (@+65279)‿(@+65279)   # variation selectors, half marks, forms, BOM
  (@+65281)‿(@+65312), (@+65339)‿(@+65344), (@+65371)‿(@+65381)   # fullwidth punctuation
  (@+65520)‿(@+65535)                        # specials
  (@+126976)‿(@+129791)                      # emoji and pictographs
⟩
bounds ← ∾ {𝕨‿(𝕩+1)}´¨ nonLetters

# Where each run of ten decimal digits 0–9 starts, in every script, after a start no character reaches.
digitStarts ← ¯10 ∾ ⟨
  48, 1632, 1776, 1984, 2406, 2534, 2662, 2790, 2918, 3046, 3174, 3302, 3430, 3558, 3664, 3792, 3872
  4160, 4240, 6112, 6160, 6470, 6608, 6784, 6800, 6992, 7088, 7232, 7248, 42528, 43216, 43264, 43472
  43504, 43600, 44016, 65296, 66720, 68912, 68928, 69734, 69872, 69942, 70096, 70384, 70736, 70864
  71248, 71360, 71376, 71386, 71472, 71904, 72016, 72688, 72784, 73040, 73120, 73552, 90416, 92768
  92864, 93008, 93552, 118000, 120782, 120792, 120802, 120812, 120822, 123200, 123632, 124144, 124401
  125264, 130032
⟩
IsDigit ← { c ← 𝕩 - @ ⋄ 10 > c - (1 -˜ digitStarts ⍋ c) ⊏ digitStarts }

IsLetter ← (¬ 2 | bounds⊸⍋) ∧ ¬∘IsDigit

CalculateFrequencies ⇐ {
  s ← IsLetter⊸/ Lower ∾𝕩
  u ← ∧⍷s
  u ⋈¨ /⁼ u⊐s
}
