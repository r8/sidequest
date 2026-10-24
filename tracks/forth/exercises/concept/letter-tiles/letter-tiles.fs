\ True if c is an ASCII letter of either case.
: letter? ( c -- flag )
  true abort" implement me" ;

\ A lower-case letter in upper case; any other character unchanged.
: upper-case ( c -- c' )
  true abort" implement me" ;

\ True if c is A, E, I, O or U, in either case.
: vowel? ( c -- flag )
  true abort" implement me" ;

\ The letter's place in the alphabet, 1 to 26.
: letter-number ( c -- n )
  true abort" implement me" ;

\ 0 for a non-letter, 1 for a vowel, 8 for J Q X Z, 2 for any other letter.
: tile-points ( c -- points )
  true abort" implement me" ;
