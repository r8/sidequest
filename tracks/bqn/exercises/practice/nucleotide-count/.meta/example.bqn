# NucleotideCounts strand → the counts of A, C, G and T, in that order (a list of four numbers);
# errors with "Invalid nucleotide in strand" on any other character
NucleotideCounts ⇐ {
  i ← "ACGT" ⊐ 𝕩
  "Invalid nucleotide in strand" ! ∧´ i < 4
  4 ↑ /⁼ i
}
