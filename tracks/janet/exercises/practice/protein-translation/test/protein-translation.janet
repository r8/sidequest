(import test :as t)
(import ../protein-translation :as sol)

(t/deftest "Empty RNA sequence results in no proteins"
  (t/assert-equal [] (sol/proteins "")))

(t/deftest "Methionine RNA sequence"
  (t/assert-equal ["Methionine"] (sol/proteins "AUG")))

(t/deftest "Phenylalanine RNA sequence 1"
  (t/assert-equal ["Phenylalanine"] (sol/proteins "UUU")))

(t/deftest "Phenylalanine RNA sequence 2"
  (t/assert-equal ["Phenylalanine"] (sol/proteins "UUC")))

(t/deftest "Leucine RNA sequence 1"
  (t/assert-equal ["Leucine"] (sol/proteins "UUA")))

(t/deftest "Leucine RNA sequence 2"
  (t/assert-equal ["Leucine"] (sol/proteins "UUG")))

(t/deftest "Serine RNA sequence 1"
  (t/assert-equal ["Serine"] (sol/proteins "UCU")))

(t/deftest "Serine RNA sequence 2"
  (t/assert-equal ["Serine"] (sol/proteins "UCC")))

(t/deftest "Serine RNA sequence 3"
  (t/assert-equal ["Serine"] (sol/proteins "UCA")))

(t/deftest "Serine RNA sequence 4"
  (t/assert-equal ["Serine"] (sol/proteins "UCG")))

(t/deftest "Tyrosine RNA sequence 1"
  (t/assert-equal ["Tyrosine"] (sol/proteins "UAU")))

(t/deftest "Tyrosine RNA sequence 2"
  (t/assert-equal ["Tyrosine"] (sol/proteins "UAC")))

(t/deftest "Cysteine RNA sequence 1"
  (t/assert-equal ["Cysteine"] (sol/proteins "UGU")))

(t/deftest "Cysteine RNA sequence 2"
  (t/assert-equal ["Cysteine"] (sol/proteins "UGC")))

(t/deftest "Tryptophan RNA sequence"
  (t/assert-equal ["Tryptophan"] (sol/proteins "UGG")))

(t/deftest "STOP codon RNA sequence 1"
  (t/assert-equal [] (sol/proteins "UAA")))

(t/deftest "STOP codon RNA sequence 2"
  (t/assert-equal [] (sol/proteins "UAG")))

(t/deftest "STOP codon RNA sequence 3"
  (t/assert-equal [] (sol/proteins "UGA")))

(t/deftest "Sequence of two protein codons translates into proteins"
  (t/assert-equal ["Phenylalanine" "Phenylalanine"] (sol/proteins "UUUUUU")))

(t/deftest "Sequence of two different protein codons translates into proteins"
  (t/assert-equal ["Leucine" "Leucine"] (sol/proteins "UUAUUG")))

(t/deftest "Translate RNA strand into correct protein list"
  (t/assert-equal ["Methionine" "Phenylalanine" "Tryptophan"] (sol/proteins "AUGUUUUGG")))

(t/deftest "Translation stops if STOP codon at beginning of sequence"
  (t/assert-equal [] (sol/proteins "UAGUGG")))

(t/deftest "Translation stops if STOP codon at end of two-codon sequence"
  (t/assert-equal ["Tryptophan"] (sol/proteins "UGGUAG")))

(t/deftest "Translation stops if STOP codon at end of three-codon sequence"
  (t/assert-equal ["Methionine" "Phenylalanine"] (sol/proteins "AUGUUUUAA")))

(t/deftest "Translation stops if STOP codon in middle of three-codon sequence"
  (t/assert-equal ["Tryptophan"] (sol/proteins "UGGUAGUGG")))

(t/deftest "Translation stops if STOP codon in middle of six-codon sequence"
  (t/assert-equal ["Tryptophan" "Cysteine" "Tyrosine"] (sol/proteins "UGGUGUUAUUAAUGGUUU")))

(t/deftest "Sequence of two non-STOP codons does not translate to a STOP codon"
  (t/assert-equal ["Methionine" "Methionine"] (sol/proteins "AUGAUG")))

(t/deftest "Unknown amino acids, not part of a codon, can't translate"
  (t/assert-error "Invalid codon" (sol/proteins "XYZ")))

(t/deftest "Incomplete RNA sequence can't translate"
  (t/assert-error "Invalid codon" (sol/proteins "AUGU")))

(t/deftest "Incomplete RNA sequence can translate if valid until a STOP codon"
  (t/assert-equal ["Phenylalanine" "Phenylalanine"] (sol/proteins "UUCUUCUAAUGGU")))

(t/run)
