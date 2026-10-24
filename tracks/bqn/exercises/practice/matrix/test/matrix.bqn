t ← •Import "../lib/test.bqn"
g ← •Import "../matrix.bqn"

Lines ← {1↓∾ (@+10)⊸∾¨ 𝕩}  # join rows with newlines

t.Run ⟨
  "extract row from one number matrix"‿{𝕊: ⟨1⟩ t.Expect 1 g.Row "1"}
  "can extract row"‿{𝕊: 3‿4 t.Expect 2 g.Row Lines "1 2"‿"3 4"}
  "extract row where numbers have different widths"‿{𝕊: 10‿20 t.Expect 2 g.Row Lines "1 2"‿"10 20"}
  "can extract row from non-square matrix with no corresponding column"‿{𝕊: 8‿7‿6 t.Expect 4 g.Row Lines "1 2 3"‿"4 5 6"‿"7 8 9"‿"8 7 6"}
  "extract column from one number matrix"‿{𝕊: ⟨1⟩ t.Expect 1 g.Column "1"}
  "can extract column"‿{𝕊: 3‿6‿9 t.Expect 3 g.Column Lines "1 2 3"‿"4 5 6"‿"7 8 9"}
  "can extract column from non-square matrix with no corresponding row"‿{𝕊: 4‿8‿6 t.Expect 4 g.Column Lines "1 2 3 4"‿"5 6 7 8"‿"9 8 7 6"}
  "extract column where numbers have different widths"‿{𝕊: 1903‿3‿4 t.Expect 2 g.Column Lines "89 1903 3"‿"18 3 1"‿"9 4 800"}
⟩
