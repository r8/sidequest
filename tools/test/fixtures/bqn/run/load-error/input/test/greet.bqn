t ← •Import "../lib/test.bqn"
g ← •Import "../greet.bqn"

t.Run ⟨
  "stub raises"‿{𝕊: "Hello, you!" t.Expect g.Greet "you"}
  "index out of range"‿{𝕊: 0 t.Expect g.Double 3}
  "floats"‿{𝕊: 2.5 t.Approx 2.505}
⟩
