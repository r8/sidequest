require ../lib/test.fs
require ../rna-transcription.fs

test" Empty RNA sequence"  0 0 to-rna s" " assert-str= ;test
test" RNA complement of cytosine is guanine"  s" C" to-rna s" G" assert-str= ;test
test" RNA complement of guanine is cytosine"  s" G" to-rna s" C" assert-str= ;test
test" RNA complement of thymine is adenine"  s" T" to-rna s" A" assert-str= ;test
test" RNA complement of adenine is uracil"  s" A" to-rna s" U" assert-str= ;test
test" RNA complement"  s" ACGTGGTCTTAA" to-rna s" UGCACCAGAAUU" assert-str= ;test

\ Not in the canonical data: a strand longer than any fixed-size buffer a solution might reach for.
create long-dna 1000 chars allot  long-dna 1000 char G fill  char A long-dna 999 chars + c!
create long-rna 1000 chars allot  long-rna 1000 char C fill  char U long-rna 999 chars + c!
test" a long strand"  long-dna 1000 to-rna long-rna 1000 assert-str= ;test

end-tests
