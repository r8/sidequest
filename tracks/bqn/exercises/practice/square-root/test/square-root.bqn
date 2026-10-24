t ← •Import "../lib/test.bqn"
g ← •Import "../square-root.bqn"

t.Run ⟨
  "root of 1"‿{𝕊: 1 t.Expect g.SquareRoot 1}
  "root of 4"‿{𝕊: 2 t.Expect g.SquareRoot 4}
  "root of 25"‿{𝕊: 5 t.Expect g.SquareRoot 25}
  "root of 81"‿{𝕊: 9 t.Expect g.SquareRoot 81}
  "root of 196"‿{𝕊: 14 t.Expect g.SquareRoot 196}
  "root of 65025"‿{𝕊: 255 t.Expect g.SquareRoot 65025}
  # Not in the canonical data: a large square, whose root is far too big to search one by one.
  "root of 99999980000001"‿{𝕊: 9999999 t.Expect g.SquareRoot 99999980000001}
⟩
