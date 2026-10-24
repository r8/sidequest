# SpiralMatrix size → a size×size table (rank 2) holding 1 to size² clockwise from the top left;
# size 0 gives a 0×0 table

# rows‿cols: the top row, then the rest is a cols×(rows-1) spiral turned clockwise
Spiral ← {𝕊 0‿c: 0‿c⥊0 ; 𝕊 r‿c: (1+↕c) ∾ c + ⍉⌽ 𝕊 c‿(r-1)}

SpiralMatrix ⇐ {Spiral 𝕩‿𝕩}
