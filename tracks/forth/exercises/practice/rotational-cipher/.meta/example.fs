\ rotate shifts every letter n places along the alphabet (0 <= n <= 26), keeping its case;
\ other characters pass through. The result is in a buffer the solution owns, valid until
\ the next call:  s" OMG" 5 rotate  gives "TRL".
\ The buffer is allocated memory, resized to fit each string.
variable rotated  1 allocate throw rotated !
: room ( u -- ) chars 1 max  rotated @ swap resize throw  rotated ! ;

: in-alphabet? ( c first -- flag ) dup 26 + within ;

: rotate-from ( c first n -- c' ) >r tuck - r> + 26 mod + ;

: rotate-char ( c n -- c' )
  over [char] a in-alphabet? if [char] a swap rotate-from exit then
  over [char] A in-alphabet? if [char] A swap rotate-from exit then
  drop ;

: rotate ( c-addr u n -- c-addr2 u2 )
  over room
  swap dup >r 0 ?do  ( c-addr n )
    over i chars + c@ over rotate-char  rotated @ i chars + c!
  loop
  2drop rotated @ r> ;
