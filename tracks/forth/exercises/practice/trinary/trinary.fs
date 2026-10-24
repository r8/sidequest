\ Convert a string of trinary digits to its decimal value. A string holding anything other
\ than the digits 0, 1 and 2 is invalid and converts to 0:
\   s" 112" trinary>decimal  ( -- 14 )
: trinary>decimal ( c-addr u -- n )
  true abort" implement me" ;
