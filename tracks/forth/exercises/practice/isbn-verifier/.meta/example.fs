\ True when the string is a valid ISBN-10: ten digits, optionally separated by dashes, the last
\ of which may be X (standing for 10).
variable sum  variable #digits

: digit? ( c -- flag ) [char] 0 [char] 9 1+ within ;

\ Weights run from 10 for the first digit down to 1 for the check digit.
: add-digit ( n -- ) 10 #digits @ - * sum +!  1 #digits +! ;

\ X is a digit only in the check position.
: digit-value ( c -- n true | false )
  dup digit? if [char] 0 - true exit then
  [char] X = #digits @ 9 = and if 10 true else false then ;

\ False when c can't appear at this point of an ISBN.
: isbn-char ( c -- flag )
  dup [char] - = if drop true exit then
  #digits @ 10 = if drop false exit then
  digit-value dup if drop add-digit true then ;

: valid-isbn? ( c-addr u -- flag )
  0 sum !  0 #digits !
  bounds ?do  i c@ isbn-char 0= if false unloop exit then  loop
  #digits @ 10 =  sum @ 11 mod 0=  and ;
