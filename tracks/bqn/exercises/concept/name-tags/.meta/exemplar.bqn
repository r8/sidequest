# Badge name → "Hello, my name is " followed by the name
Badge ⇐ {"Hello, my name is " ∾ 𝕩}

# first FullName family → the two names joined by a space
FullName ⇐ {𝕨 ∾ ' ' ∾ 𝕩}

# Shout name → the name with every small letter a–z made a capital
Shout ⇐ {𝕩 - 32 × ('a' ≤ 𝕩) ∧ 𝕩 ≤ 'z'}

# TableLetter n → the letter of table n (counting from 0): 'A', 'B', …; works on lists of numbers too
TableLetter ⇐ {'A' + 𝕩}

# Quote text → the text between two double-quote characters
Quote ⇐ {'"' ∾ 𝕩 ∾ '"'}
