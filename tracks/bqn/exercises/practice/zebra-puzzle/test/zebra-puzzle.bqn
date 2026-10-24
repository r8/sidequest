t ← •Import "../lib/test.bqn"
g ← •Import "../zebra-puzzle.bqn"

t.Run ⟨
  "resident who drinks water"‿{𝕊: "Norwegian" t.Expect g.DrinksWater @}
  "resident who owns zebra"‿{𝕊: "Japanese" t.Expect g.OwnsZebra @}
⟩
