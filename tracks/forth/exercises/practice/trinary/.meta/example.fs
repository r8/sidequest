\ Convert a string of trinary digits to its decimal value. A string holding anything other
\ than the digits 0, 1 and 2 is invalid and converts to 0:
\   s" 112" trinary>decimal  ( -- 14 )
: trit ( char -- n flag ) [char] 0 - dup 0 3 within ;

: trinary>decimal ( c-addr u -- n )
  0 -rot bounds ?do
    i c@ trit 0= if 2drop 0 unloop exit then
    swap 3 * +
  loop ;
