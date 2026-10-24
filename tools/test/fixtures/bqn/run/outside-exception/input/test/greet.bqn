t ← •Import "../lib/test.bqn"
g ← •Import "../greet.bqn"

setup ← "setup failed" ! 0
t.Run ⟨"never"‿{𝕊: 42 t.Expect g.Double 21}⟩
