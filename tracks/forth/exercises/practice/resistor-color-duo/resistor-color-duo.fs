\ The two-digit value of a resistor's first two bands, given their color names:
\   s" brown" s" black" resistor-value  ( -- 10 )
\ Band colors and their digits:
\   black 0, brown 1, red 2, orange 3, yellow 4, green 5, blue 6, violet 7, grey 8, white 9.
\ Throw -24 (invalid numeric argument) for a name that isn't one of the ten colors.
: resistor-value ( c-addr1 u1 c-addr2 u2 -- n )
  true abort" implement me" ;
