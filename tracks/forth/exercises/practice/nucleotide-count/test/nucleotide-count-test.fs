require ../lib/test.fs
require ../nucleotide-count.fs

\ Compares the four counts A C G T with the four expected ones, in that order.
: assert-counts ( a c g t a' c' g' t' -- )
  4 roll swap assert=  3 roll swap assert=  2 roll swap assert=  assert= ;

test" empty strand"  s" " count-nucleotides  0 0 0 0 assert-counts ;test
test" can count one nucleotide in single-character input"  s" G" count-nucleotides  0 0 1 0 assert-counts ;test
test" strand with repeated nucleotide"  s" GGGGGGG" count-nucleotides  0 0 7 0 assert-counts ;test
test" strand with multiple nucleotides"
  s" AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" count-nucleotides
  20 12 17 21 assert-counts ;test

: invalid-strand ( -- a c g t ) s" AGXXACT" count-nucleotides ;
test" strand with invalid nucleotides"  ['] invalid-strand -24 assert-xt-throws ;test

end-tests
