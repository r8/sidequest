t ← •Import "../lib/test.bqn"
g ← •Import "../difference-of-squares.bqn"

t.Run ⟨
  "square of sum 1"‿{𝕊: 1 t.Expect g.SquareOfSum 1}
  "square of sum 5"‿{𝕊: 225 t.Expect g.SquareOfSum 5}
  "square of sum 100"‿{𝕊: 25502500 t.Expect g.SquareOfSum 100}
  "sum of squares 1"‿{𝕊: 1 t.Expect g.SumOfSquares 1}
  "sum of squares 5"‿{𝕊: 55 t.Expect g.SumOfSquares 5}
  "sum of squares 100"‿{𝕊: 338350 t.Expect g.SumOfSquares 100}
  "difference of squares 1"‿{𝕊: 0 t.Expect g.DifferenceOfSquares 1}
  "difference of squares 5"‿{𝕊: 170 t.Expect g.DifferenceOfSquares 5}
  "difference of squares 100"‿{𝕊: 25164150 t.Expect g.DifferenceOfSquares 100}
⟩
