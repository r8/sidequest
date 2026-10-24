t ← •Import "../lib/test.bqn"
g ← •Import "../paper-folding.bqn"

t.Run ⟨
  "1. an unfolded sheet"‿{𝕊: 0.1 t.Approx g.Thickness 0}
  "1. one fold"‿{𝕊: 0.2 t.Approx g.Thickness 1}
  "1. three folds"‿{𝕊: 0.8 t.Approx g.Thickness 3}
  "1. ten folds"‿{𝕊: 102.4 t.Approx g.Thickness 10}
  "2. as thick as a sheet already is"‿{𝕊: 0 t.Expect g.FoldsToReach 0.1}
  "2. thinner than a sheet"‿{𝕊: 0 t.Expect g.FoldsToReach 0.05}
  "2. a millimetre"‿{𝕊: 4 t.Expect g.FoldsToReach 1}
  "2. exactly reached"‿{𝕊: 3 t.Expect g.FoldsToReach 0.8}
  "2. a metre"‿{𝕊: 14 t.Expect g.FoldsToReach 1000}
  "3. sides with a common factor"‿{𝕊: 6 t.Expect g.LargestSquare 12‿18}
  "3. one side divides the other"‿{𝕊: 7 t.Expect g.LargestSquare 21‿7}
  "3. sides with no common factor"‿{𝕊: 1 t.Expect g.LargestSquare 13‿8}
  "3. a square sheet"‿{𝕊: 9 t.Expect g.LargestSquare 9‿9}
  "4. a small sheet"‿{𝕊: 4 t.Expect g.CutSquares 5‿3}
  "4. a square sheet"‿{𝕊: 1 t.Expect g.CutSquares 4‿4}
  "4. a long strip"‿{𝕊: 6 t.Expect g.CutSquares 6‿1}
  "4. an A4 sheet in millimetres"‿{𝕊: 11 t.Expect g.CutSquares 297‿210}
  "5. A0"‿{𝕊: 841‿1189 t.Expect g.PaperSize 0}
  "5. A1"‿{𝕊: 594‿841 t.Expect g.PaperSize 1}
  "5. A4"‿{𝕊: 210‿297 t.Expect g.PaperSize 4}
  "5. A7"‿{𝕊: 74‿105 t.Expect g.PaperSize 7}
⟩
