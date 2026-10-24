t ← •Import "../lib/test.bqn"
g ← •Import "../protein-translation.bqn"

t.Run ⟨
  "Empty RNA sequence results in no proteins"‿{𝕊: ⟨⟩ t.Expect g.Proteins ""}
  "Methionine RNA sequence"‿{𝕊: ⟨"Methionine"⟩ t.Expect g.Proteins "AUG"}
  "Phenylalanine RNA sequence 1"‿{𝕊: ⟨"Phenylalanine"⟩ t.Expect g.Proteins "UUU"}
  "Phenylalanine RNA sequence 2"‿{𝕊: ⟨"Phenylalanine"⟩ t.Expect g.Proteins "UUC"}
  "Leucine RNA sequence 1"‿{𝕊: ⟨"Leucine"⟩ t.Expect g.Proteins "UUA"}
  "Leucine RNA sequence 2"‿{𝕊: ⟨"Leucine"⟩ t.Expect g.Proteins "UUG"}
  "Serine RNA sequence 1"‿{𝕊: ⟨"Serine"⟩ t.Expect g.Proteins "UCU"}
  "Serine RNA sequence 2"‿{𝕊: ⟨"Serine"⟩ t.Expect g.Proteins "UCC"}
  "Serine RNA sequence 3"‿{𝕊: ⟨"Serine"⟩ t.Expect g.Proteins "UCA"}
  "Serine RNA sequence 4"‿{𝕊: ⟨"Serine"⟩ t.Expect g.Proteins "UCG"}
  "Tyrosine RNA sequence 1"‿{𝕊: ⟨"Tyrosine"⟩ t.Expect g.Proteins "UAU"}
  "Tyrosine RNA sequence 2"‿{𝕊: ⟨"Tyrosine"⟩ t.Expect g.Proteins "UAC"}
  "Cysteine RNA sequence 1"‿{𝕊: ⟨"Cysteine"⟩ t.Expect g.Proteins "UGU"}
  "Cysteine RNA sequence 2"‿{𝕊: ⟨"Cysteine"⟩ t.Expect g.Proteins "UGC"}
  "Tryptophan RNA sequence"‿{𝕊: ⟨"Tryptophan"⟩ t.Expect g.Proteins "UGG"}
  "STOP codon RNA sequence 1"‿{𝕊: ⟨⟩ t.Expect g.Proteins "UAA"}
  "STOP codon RNA sequence 2"‿{𝕊: ⟨⟩ t.Expect g.Proteins "UAG"}
  "STOP codon RNA sequence 3"‿{𝕊: ⟨⟩ t.Expect g.Proteins "UGA"}
  "Sequence of two protein codons translates into proteins"‿{𝕊: "Phenylalanine"‿"Phenylalanine" t.Expect g.Proteins "UUUUUU"}
  "Sequence of two different protein codons translates into proteins"‿{𝕊: "Leucine"‿"Leucine" t.Expect g.Proteins "UUAUUG"}
  "Translate RNA strand into correct protein list"‿{𝕊: "Methionine"‿"Phenylalanine"‿"Tryptophan" t.Expect g.Proteins "AUGUUUUGG"}
  "Translation stops if STOP codon at beginning of sequence"‿{𝕊: ⟨⟩ t.Expect g.Proteins "UAGUGG"}
  "Translation stops if STOP codon at end of two-codon sequence"‿{𝕊: ⟨"Tryptophan"⟩ t.Expect g.Proteins "UGGUAG"}
  "Translation stops if STOP codon at end of three-codon sequence"‿{𝕊: "Methionine"‿"Phenylalanine" t.Expect g.Proteins "AUGUUUUAA"}
  "Translation stops if STOP codon in middle of three-codon sequence"‿{𝕊: ⟨"Tryptophan"⟩ t.Expect g.Proteins "UGGUAGUGG"}
  "Translation stops if STOP codon in middle of six-codon sequence"‿{𝕊: "Tryptophan"‿"Cysteine"‿"Tyrosine" t.Expect g.Proteins "UGGUGUUAUUAAUGGUUU"}
  "Sequence of two non-STOP codons does not translate to a STOP codon"‿{𝕊: "Methionine"‿"Methionine" t.Expect g.Proteins "AUGAUG"}
  "Unknown amino acids, not part of a codon, can't translate"‿{𝕊: {𝕊: g.Proteins "XYZ"} t._throws "Invalid codon"}
  "Incomplete RNA sequence can't translate"‿{𝕊: {𝕊: g.Proteins "AUGU"} t._throws "Invalid codon"}
  "Incomplete RNA sequence can translate if valid until a STOP codon"‿{𝕊: "Phenylalanine"‿"Phenylalanine" t.Expect g.Proteins "UUCUUCUAAUGGU"}
⟩
