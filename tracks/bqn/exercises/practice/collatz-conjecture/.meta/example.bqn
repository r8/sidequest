# Steps n → the number of Collatz steps (halve if even, else 3n+1) to reach 1;
# errors with "Only positive integers are allowed" unless n ≥ 1
Steps ⇐ {
  𝕩 < 1 ? "Only positive integers are allowed" ! 0 ;
  𝕩 = 1 ? 0 ;
  1 + 𝕊 (2|𝕩) ⊑ ⟨𝕩÷2, 1+3×𝕩⟩
}
