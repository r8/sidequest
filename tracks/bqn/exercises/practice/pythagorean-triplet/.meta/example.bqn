# TripletsWithSum n → every a‿b‿c with a<b<c, a²+b²=c² and a+b+c=n, ordered by a
# Eliminating c from both equations gives b = n×(n-2a) ÷ 2×(n-a), so only a needs searching.
TripletsWithSum ⇐ {𝕊 n:
  a ← 1 + ↕⌊n÷3
  b ← (n×n-2×a) ÷ 2×n-a
  keep ← (b=⌊b) ∧ a<b
  (keep/a) {𝕨‿𝕩‿(n-𝕨+𝕩)}¨ keep/b
}
