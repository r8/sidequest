require ../lib/test.fs
require ../rotational-cipher.fs

test" rotate a by 0, same output as input"  s" a" 0 rotate s" a" assert-str= ;test
test" rotate a by 1"  s" a" 1 rotate s" b" assert-str= ;test
test" rotate a by 26, same output as input"  s" a" 26 rotate s" a" assert-str= ;test
test" rotate m by 13"  s" m" 13 rotate s" z" assert-str= ;test
test" rotate n by 13 with wrap around alphabet"  s" n" 13 rotate s" a" assert-str= ;test
test" rotate capital letters"  s" OMG" 5 rotate s" TRL" assert-str= ;test
test" rotate spaces"  s" O M G" 5 rotate s" T R L" assert-str= ;test
test" rotate numbers"
  s" Testing 1 2 3 testing" 4 rotate s" Xiwxmrk 1 2 3 xiwxmrk" assert-str= ;test
test" rotate punctuation"
  s" Let's eat, Grandma!" 21 rotate s" Gzo'n zvo, Bmviyhv!" assert-str= ;test
test" rotate all letters"
  s" The quick brown fox jumps over the lazy dog." 13 rotate
  s" Gur dhvpx oebja sbk whzcf bire gur ynml qbt." assert-str= ;test

\ Not in the canonical data: a text longer than any fixed-size buffer a solution might reach for.
create long-text 1000 chars allot  long-text 1000 char a fill  char Z long-text 999 chars + c!
create long-rotated 1000 chars allot  long-rotated 1000 char b fill  char A long-rotated 999 chars + c!
test" rotate a long text"  long-text 1000 1 rotate long-rotated 1000 assert-str= ;test

end-tests
