t ← •Import "../lib/test.bqn"
g ← •Import "../greet.bqn"

t.Run ⟨
  "passes"‿{𝕊: 42 t.Expect g.Double 21}
  "fails on a list"‿{𝕊: 1‿2 t.Expect g.Double 1‿2}
  "fails on a missing error"‿{𝕊: {𝕊: g.Double 1} t._throws "boom"}
  "fails on a float"‿{𝕊: 2.5 t.Approx 2.6}
⟩
