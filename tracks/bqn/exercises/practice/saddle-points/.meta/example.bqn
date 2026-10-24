# SaddlePoints rows → the row‿column positions (counting from 1) of every value that is the largest
# in its row and the smallest in its column, sorted; the matrix is given as a list of rows
SaddlePoints ⇐ {
  m ← >𝕩
  1 + (⥊ (m = ⌈´˘m) ∧ m =⎉1 ⌊˝m) / ⥊↕≢m
}
