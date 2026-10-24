require ../lib/test.fs
require ../reverse-string.fs

test" an empty string"  0 0 reverse s" " assert-str= ;test
test" a word"  s" robot" reverse s" tobor" assert-str= ;test
test" a capitalized word"  s" Ramen" reverse s" nemaR" assert-str= ;test
test" a sentence with punctuation"  s" I'm hungry!" reverse s" !yrgnuh m'I" assert-str= ;test
test" a palindrome"  s" racecar" reverse s" racecar" assert-str= ;test
test" an even-sized word"  s" drawer" reverse s" reward" assert-str= ;test

\ Not in the canonical data: a string longer than any fixed-size buffer a solution might reach for.
create long-string 1000 chars allot  long-string 1000 char a fill  char z long-string c!
create long-reversed 1000 chars allot  long-reversed 1000 char a fill  char z long-reversed 999 chars + c!
test" a long string"  long-string 1000 reverse long-reversed 1000 assert-str= ;test

end-tests
