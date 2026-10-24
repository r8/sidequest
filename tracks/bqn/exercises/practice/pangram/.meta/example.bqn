# IsPangram sentence → 1 if it uses every letter a–z at least once, ignoring case, else 0
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}

IsPangram ⇐ {∧´ ('a'+↕26) ∊ Lower 𝕩}
