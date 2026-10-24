require ../lib/test.fs
require ../protein-translation.fs

test" Empty RNA sequence results in no proteins"  s" " proteins s" " assert-str= ;test
test" Methionine RNA sequence"  s" AUG" proteins s" Methionine" assert-str= ;test
test" Phenylalanine RNA sequence 1"  s" UUU" proteins s" Phenylalanine" assert-str= ;test
test" Phenylalanine RNA sequence 2"  s" UUC" proteins s" Phenylalanine" assert-str= ;test
test" Leucine RNA sequence 1"  s" UUA" proteins s" Leucine" assert-str= ;test
test" Leucine RNA sequence 2"  s" UUG" proteins s" Leucine" assert-str= ;test
test" Serine RNA sequence 1"  s" UCU" proteins s" Serine" assert-str= ;test
test" Serine RNA sequence 2"  s" UCC" proteins s" Serine" assert-str= ;test
test" Serine RNA sequence 3"  s" UCA" proteins s" Serine" assert-str= ;test
test" Serine RNA sequence 4"  s" UCG" proteins s" Serine" assert-str= ;test
test" Tyrosine RNA sequence 1"  s" UAU" proteins s" Tyrosine" assert-str= ;test
test" Tyrosine RNA sequence 2"  s" UAC" proteins s" Tyrosine" assert-str= ;test
test" Cysteine RNA sequence 1"  s" UGU" proteins s" Cysteine" assert-str= ;test
test" Cysteine RNA sequence 2"  s" UGC" proteins s" Cysteine" assert-str= ;test
test" Tryptophan RNA sequence"  s" UGG" proteins s" Tryptophan" assert-str= ;test
test" STOP codon RNA sequence 1"  s" UAA" proteins s" " assert-str= ;test
test" STOP codon RNA sequence 2"  s" UAG" proteins s" " assert-str= ;test
test" STOP codon RNA sequence 3"  s" UGA" proteins s" " assert-str= ;test
test" Sequence of two protein codons translates into proteins"  s" UUUUUU" proteins s" Phenylalanine Phenylalanine" assert-str= ;test
test" Sequence of two different protein codons translates into proteins"  s" UUAUUG" proteins s" Leucine Leucine" assert-str= ;test
test" Translate RNA strand into correct protein list"  s" AUGUUUUGG" proteins s" Methionine Phenylalanine Tryptophan" assert-str= ;test
test" Translation stops if STOP codon at beginning of sequence"  s" UAGUGG" proteins s" " assert-str= ;test
test" Translation stops if STOP codon at end of two-codon sequence"  s" UGGUAG" proteins s" Tryptophan" assert-str= ;test
test" Translation stops if STOP codon at end of three-codon sequence"  s" AUGUUUUAA" proteins s" Methionine Phenylalanine" assert-str= ;test
test" Translation stops if STOP codon in middle of three-codon sequence"  s" UGGUAGUGG" proteins s" Tryptophan" assert-str= ;test
test" Translation stops if STOP codon in middle of six-codon sequence"  s" UGGUGUUAUUAAUGGUUU" proteins s" Tryptophan Cysteine Tyrosine" assert-str= ;test
test" Sequence of two non-STOP codons does not translate to a STOP codon"  s" AUGAUG" proteins s" Methionine Methionine" assert-str= ;test
: translate-xyz ( -- ) s" XYZ" proteins ;
test" Unknown amino acids, not part of a codon, can't translate"  ['] translate-xyz -24 assert-xt-throws ;test
: translate-augu ( -- ) s" AUGU" proteins ;
test" Incomplete RNA sequence can't translate"  ['] translate-augu -24 assert-xt-throws ;test
test" Incomplete RNA sequence can translate if valid until a STOP codon"  s" UUCUUCUAAUGGU" proteins s" Phenylalanine Phenylalanine" assert-str= ;test

\ Not in the canonical data: a strand longer than any fixed-size buffer a solution might reach for.
create long-strand 3000 chars allot  long-strand 3000 char U fill
create long-protein 14000 chars allot
: fill-protein ( -- ) 1000 0 do  s" Phenylalanine " long-protein i 14 * chars + swap chars move  loop ;
fill-protein
test" a long strand"  long-strand 3000 proteins long-protein 13999 assert-str= ;test

end-tests
