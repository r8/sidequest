require ../lib/test.fs
require ../raindrops.fs

test" the sound for 1 is 1"  1 convert s" 1" assert-str= ;test
test" the sound for 3 is Pling"  3 convert s" Pling" assert-str= ;test
test" the sound for 5 is Plang"  5 convert s" Plang" assert-str= ;test
test" the sound for 7 is Plong"  7 convert s" Plong" assert-str= ;test
test" the sound for 6 is Pling as it has a factor 3"  6 convert s" Pling" assert-str= ;test
test" 2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base"
  8 convert s" 8" assert-str= ;test
test" the sound for 9 is Pling as it has a factor 3"  9 convert s" Pling" assert-str= ;test
test" the sound for 10 is Plang as it has a factor 5"  10 convert s" Plang" assert-str= ;test
test" the sound for 14 is Plong as it has a factor of 7"  14 convert s" Plong" assert-str= ;test
test" the sound for 15 is PlingPlang as it has factors 3 and 5"
  15 convert s" PlingPlang" assert-str= ;test
test" the sound for 21 is PlingPlong as it has factors 3 and 7"
  21 convert s" PlingPlong" assert-str= ;test
test" the sound for 25 is Plang as it has a factor 5"  25 convert s" Plang" assert-str= ;test
test" the sound for 27 is Pling as it has a factor 3"  27 convert s" Pling" assert-str= ;test
test" the sound for 35 is PlangPlong as it has factors 5 and 7"
  35 convert s" PlangPlong" assert-str= ;test
test" the sound for 49 is Plong as it has a factor 7"  49 convert s" Plong" assert-str= ;test
test" the sound for 52 is 52"  52 convert s" 52" assert-str= ;test
test" the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7"
  105 convert s" PlingPlangPlong" assert-str= ;test
test" the sound for 3125 is Plang as it has a factor 5"  3125 convert s" Plang" assert-str= ;test

end-tests
