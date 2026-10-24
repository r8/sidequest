# The matrix is a string: rows separated by newlines, numbers within a row by single spaces.

Split ← (⊢-˜¬×+`)∘=⊔⊢
Parse ← {> •ParseFloat¨¨ ' '⊸Split¨ (@+10) Split 𝕩}

# index Row matrix → the numbers in row index (counting from 1)
Row ⇐ {(𝕨-1) ⊏ Parse 𝕩}

# index Column matrix → the numbers in column index (counting from 1)
Column ⇐ {(𝕨-1) ⊏˘ Parse 𝕩}
