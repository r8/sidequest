require ../lib/test.fs
require ../etl.fs

test" single letter"  s" A" 1  1 transform  [char] a score 1 assert=  #letters 1 assert= ;test
test" single score with multiple letters"
  s" AEIOU" 1  1 transform
  [char] a score 1 assert=  [char] e score 1 assert=  [char] i score 1 assert=  [char] o score 1 assert=
  [char] u score 1 assert=  #letters 5 assert=
;test
test" multiple scores with multiple letters"
  s" AE" 1  s" DG" 2  2 transform
  [char] a score 1 assert=  [char] d score 2 assert=  [char] e score 1 assert=  [char] g score 2 assert=
  #letters 4 assert=
;test
test" multiple scores with differing numbers of letters"
  s" AEIOULNRST" 1  s" DG" 2  s" BCMP" 3  s" FHVWY" 4  s" K" 5  s" JX" 8  s" QZ" 10  7 transform
  [char] a score 1 assert=  [char] b score 3 assert=  [char] c score 3 assert=  [char] d score 2 assert=
  [char] e score 1 assert=  [char] f score 4 assert=  [char] g score 2 assert=  [char] h score 4 assert=
  [char] i score 1 assert=  [char] j score 8 assert=  [char] k score 5 assert=  [char] l score 1 assert=
  [char] m score 3 assert=  [char] n score 1 assert=  [char] o score 1 assert=  [char] p score 3 assert=
  [char] q score 10 assert=  [char] r score 1 assert=  [char] s score 1 assert=  [char] t score 1 assert=
  [char] u score 1 assert=  [char] v score 4 assert=  [char] w score 4 assert=  [char] x score 8 assert=
  [char] y score 4 assert=  [char] z score 10 assert=  #letters 26 assert=
;test

end-tests
