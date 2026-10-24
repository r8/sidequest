require ../lib/test.fs
require ../hamming.fs

test" empty strands"  s" " s" " distance 0 assert= ;test
test" single letter identical strands"  s" A" s" A" distance 0 assert= ;test
test" single letter different strands"  s" G" s" T" distance 1 assert= ;test
test" long identical strands"  s" GGACTGAAATCTG" s" GGACTGAAATCTG" distance 0 assert= ;test
test" long different strands"  s" GGACGGATTCTG" s" AGGACGGATTCT" distance 9 assert= ;test

: first-longer ( -- n ) s" AATG" s" AAA" distance ;
test" disallow first strand longer"  ['] first-longer -24 assert-xt-throws ;test

: second-longer ( -- n ) s" ATA" s" AGTG" distance ;
test" disallow second strand longer"  ['] second-longer -24 assert-xt-throws ;test

: first-empty ( -- n ) s" " s" G" distance ;
test" disallow empty first strand"  ['] first-empty -24 assert-xt-throws ;test

: second-empty ( -- n ) s" G" s" " distance ;
test" disallow empty second strand"  ['] second-empty -24 assert-xt-throws ;test

end-tests
