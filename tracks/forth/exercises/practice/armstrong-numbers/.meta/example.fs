\ An Armstrong number is the sum of its own digits each raised to the power of the number
\ of digits:
\   153 armstrong?  ( -- true )
: #digits ( n -- #digits ) 0 swap begin swap 1+ swap 10 / dup 0= until drop ;

: ** ( n power -- n^power ) 1 swap 0 ?do over * loop nip ;

\ Sum of each digit of n raised to the given power.
: digit-powers ( n power -- sum )
  0 rot begin ( power sum n ) 10 /mod >r  2 pick ** +  r> dup 0= until drop nip ;

: armstrong? ( n -- flag ) dup dup #digits digit-powers = ;
