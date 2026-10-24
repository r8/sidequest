# Score word → the sum of its letters' Scrabble values, ignoring case
letters ← "aeioulnrst"‿"dg"‿"bcmp"‿"fhvwy"‿"k"‿"jx"‿"qz"
values ← (≠¨letters) / 1‿2‿3‿4‿5‿8‿10
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}

Score ⇐ {+´ values ⊏˜ (∾letters) ⊐ Lower 𝕩}
