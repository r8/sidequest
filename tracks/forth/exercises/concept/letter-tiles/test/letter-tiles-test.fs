require ../lib/test.fs
require ../letter-tiles.fs

test" 1. a lower-case letter"  [char] g letter? assert-true ;test
test" 1. an upper-case letter"  [char] Q letter? assert-true ;test
test" 1. the ends of the alphabet"  [char] a letter? [char] z letter? and [char] A letter? and [char] Z letter? and assert-true ;test
test" 1. a digit is not a letter"  [char] 7 letter? assert-false ;test
test" 1. characters next to the letters are not letters"
  [char] @ letter? [char] [ letter? or [char] ` letter? or [char] { letter? or assert-false ;test

test" 2. a lower-case letter"  [char] g upper-case [char] G assert= ;test
test" 2. the last lower-case letter"  [char] z upper-case [char] Z assert= ;test
test" 2. an upper-case letter is unchanged"  [char] M upper-case [char] M assert= ;test
test" 2. punctuation is unchanged"  [char] ! upper-case [char] ! assert= ;test
test" 2. a character just after the lower-case letters is unchanged"  [char] { upper-case [char] { assert= ;test

test" 3. a lower-case vowel"  [char] e vowel? assert-true ;test
test" 3. an upper-case vowel"  [char] U vowel? assert-true ;test
test" 3. a consonant"  [char] Y vowel? assert-false ;test
test" 3. a digit"  [char] 1 vowel? assert-false ;test

test" 4. the first letter"  [char] A letter-number 1 assert= ;test
test" 4. a lower-case letter"  [char] c letter-number 3 assert= ;test
test" 4. the last letter"  [char] Z letter-number 26 assert= ;test
test" 4. the last lower-case letter"  [char] z letter-number 26 assert= ;test

test" 5. a rare letter"  [char] q tile-points 8 assert= ;test
test" 5. an upper-case rare letter"  [char] X tile-points 8 assert= ;test
test" 5. a vowel"  [char] o tile-points 1 assert= ;test
test" 5. a common consonant"  [char] T tile-points 2 assert= ;test
test" 5. a blank tile"  [char] ? tile-points 0 assert= ;test

end-tests
