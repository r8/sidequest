t ← •Import "../lib/test.bqn"
g ← •Import "../eliuds-eggs.bqn"

t.Run ⟨
  "0 eggs"‿{𝕊: 0 t.Expect g.EggCount 0}
  "1 egg"‿{𝕊: 1 t.Expect g.EggCount 16}
  "4 eggs"‿{𝕊: 4 t.Expect g.EggCount 89}
  "13 eggs"‿{𝕊: 13 t.Expect g.EggCount 2000000000}
⟩
