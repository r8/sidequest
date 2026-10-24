\ Count the eggs in the coop: the number of 1 bits in the display value, without using any
\ built-in bit-counting word:
\   89 egg-count  ( -- 4 )
: egg-count ( u -- count )
  0 swap begin ?dup while ( count u )  dup 1 and rot + swap  1 rshift  repeat ;
