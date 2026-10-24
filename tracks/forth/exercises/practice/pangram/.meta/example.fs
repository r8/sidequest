\ True when the sentence uses every letter of the English alphabet at least once, ignoring case.
: letter? ( c -- flag ) toupper [char] A [char] Z 1+ within ;
: letter-bit ( c -- mask ) toupper [char] A - 1 swap lshift ;

\ The set of letters in the string, one bit per letter.
: letters ( c-addr u -- mask )
  0 -rot bounds ?do  i c@ dup letter? if letter-bit or else drop then  loop ;

: pangram? ( c-addr u -- flag ) letters 1 26 lshift 1- = ;
