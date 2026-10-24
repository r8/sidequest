# maximumWeight MaximumValue items → the largest total value of items whose weights add up to at most
# maximumWeight, each item used at most once; items is a list of weight‿value pairs
# best has the largest value for each capacity from 0 to maximumWeight; each item can either be left
# out, or added to the best value for its weight less capacity.
MaximumValue ⇐ {
  best ← (1+𝕨) ⥊ 0
  ¯1 ⊑ best {w‿v 𝕊 b: b ⌈ (≠b) ↑ (w⥊0) ∾ v+b}´ 𝕩
}
