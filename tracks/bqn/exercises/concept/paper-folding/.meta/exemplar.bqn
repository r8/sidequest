# Thickness folds → the thickness in mm of a 0.1 mm sheet folded in half that many times
Thickness ⇐ {𝕊 0: 0.1 ; 𝕊 n: 2 × 𝕊 n - 1}

# FoldsToReach height → the fewest folds that make the sheet at least height mm thick
FoldsToReach ⇐ {
  𝕊 height: 0 𝕊 height ;
  folds 𝕊 height: height ≤ Thickness folds ? folds ;
  folds 𝕊 height: (folds + 1) 𝕊 height
}

# LargestSquare width‿height → the side of the largest square that tiles the sheet exactly
LargestSquare ⇐ {𝕊 a‿0: a ; 𝕊 a‿b: 𝕊 b‿(b | a)}

# CutSquares long‿short → how many squares are cut by repeatedly cutting the largest square
CutSquares ⇐ {𝕊 a‿0: 0 ; 𝕊 a‿b: (⌊ a ÷ b) + 𝕊 b‿(b | a)}

# PaperSize n → short‿long, the sides in mm of size An
PaperSize ⇐ {
  𝕊 0: 841‿1189 ;
  𝕊 n: short‿long ← 𝕊 n - 1 ⋄ (⌊ long ÷ 2)‿short
}
