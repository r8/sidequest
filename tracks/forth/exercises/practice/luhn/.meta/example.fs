\ True when the string is a valid number under the Luhn formula: digits and spaces only,
\ at least two digits.
variable sum  variable #digits

: digit? ( c -- flag ) [char] 0 [char] 9 1+ within ;
: double ( n -- n' ) 2* dup 9 > if 9 - then ;

\ Digits are added from the right, every second one doubled.
: add-digit ( c -- ) [char] 0 -  #digits @ 1 and if double then  sum +!  1 #digits +! ;

\ False when c is neither a digit nor a space.
: luhn-char ( c -- flag )
  dup bl = if drop true exit then
  dup digit? if add-digit true else drop false then ;

: valid? ( c-addr u -- flag )
  0 sum !  0 #digits !
  begin dup while
    1- 2dup chars + c@ luhn-char 0= if 2drop false exit then
  repeat 2drop
  #digits @ 1 >  sum @ 10 mod 0=  and ;
