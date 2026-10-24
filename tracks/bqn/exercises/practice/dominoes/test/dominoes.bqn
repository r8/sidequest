t ← •Import "../lib/test.bqn"
g ← •Import "../dominoes.bqn"

t.Run ⟨
  "empty input = empty output"‿{𝕊: 1 t.Expect g.CanChain ⟨⟩}
  "singleton input = singleton output"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿1⟩}
  "singleton that can't be chained"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿2⟩}
  "three elements"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿2, 3‿1, 2‿3⟩}
  "can reverse dominoes"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿2, 1‿3, 2‿3⟩}
  "can't be chained"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿2, 4‿1, 2‿3⟩}
  "disconnected - simple"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿1, 2‿2⟩}
  "disconnected - double loop"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿2, 2‿1, 3‿4, 4‿3⟩}
  "disconnected - single isolated"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿2, 2‿3, 3‿1, 4‿4⟩}
  "need backtrack"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿2, 2‿3, 3‿1, 2‿4, 2‿4⟩}
  "separate loops"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿2, 2‿3, 3‿1, 1‿1, 2‿2, 3‿3⟩}
  "nine elements"‿{𝕊: 1 t.Expect g.CanChain ⟨1‿2, 5‿3, 3‿1, 1‿2, 2‿4, 1‿6, 2‿3, 3‿4, 5‿6⟩}
  "separate three-domino loops"‿{𝕊: 0 t.Expect g.CanChain ⟨1‿2, 2‿3, 3‿1, 4‿5, 5‿6, 6‿4⟩}
⟩
