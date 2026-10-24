\ True if c is an ASCII letter of either case.
: letter? ( c -- flag )
  dup [char] a [char] z 1+ within  swap [char] A [char] Z 1+ within  or ;

\ A lower-case letter in upper case; any other character unchanged.
: upper-case ( c -- c' )
  dup [char] a [char] z 1+ within if [char] a [char] A - - then ;

\ True if c is A, E, I, O or U, in either case.
: vowel? ( c -- flag )
  upper-case case
    [char] A of true endof
    [char] E of true endof
    [char] I of true endof
    [char] O of true endof
    [char] U of true endof
    false swap
  endcase ;

\ The letter's place in the alphabet, 1 to 26.
: letter-number ( c -- n )
  upper-case [char] A - 1+ ;

\ 0 for a non-letter, 1 for a vowel, 8 for J Q X Z, 2 for any other letter.
: tile-points ( c -- points )
  dup letter? 0= if drop 0 exit then
  dup vowel? if drop 1 exit then
  upper-case case
    [char] J of 8 endof
    [char] Q of 8 endof
    [char] X of 8 endof
    [char] Z of 8 endof
    2 swap
  endcase ;
