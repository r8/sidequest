# Proteins strand → the names of the proteins its codons code for, in order, up to the first STOP
# codon; errors with "Invalid codon" for an unknown or incomplete codon before that
codons‿acids ← <˘ ⍉ > ⟨
  "AUG"‿"Methionine"
  "UUU"‿"Phenylalanine", "UUC"‿"Phenylalanine"
  "UUA"‿"Leucine", "UUG"‿"Leucine"
  "UCU"‿"Serine", "UCC"‿"Serine", "UCA"‿"Serine", "UCG"‿"Serine"
  "UAU"‿"Tyrosine", "UAC"‿"Tyrosine"
  "UGU"‿"Cysteine", "UGC"‿"Cysteine"
  "UGG"‿"Tryptophan"
  "UAA"‿"STOP", "UAG"‿"STOP", "UGA"‿"STOP"
⟩
stop ← acids ≡¨ <"STOP"
Proteins ⇐ {
  i ← codons ⊐ (⌊3÷˜↕≠𝕩) ⊔ 𝕩            # an unknown or incomplete codon gets ≠codons
  i ↩ (∧` ¬ i ⊏ stop∾0) / i              # up to the first STOP
  "Invalid codon" ! ∧´ i < ≠codons
  i ⊏ acids
}
