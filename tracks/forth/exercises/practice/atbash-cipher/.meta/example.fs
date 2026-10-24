\ encode and decode leave their result in a buffer the solution owns, valid until the next
\ call to either word. Letters are mirrored (a <-> z) and lowercased, digits pass through,
\ everything else is dropped. encode groups its output in blocks of five separated by spaces:
\   s" yes" encode  gives "bvh"     s" vcvix rhn" decode  gives "exercism"
\ The buffer is allocated memory, resized for each string: grouping adds at most one space for
\ every five characters, so twice the input's length is always enough.
variable cipher  1 allocate throw cipher !  variable #cipher
: room ( u -- ) 2* chars 1 max  cipher @ swap resize throw  cipher ! ;

: c>cipher ( c -- ) cipher @ #cipher @ chars + c!  1 #cipher +! ;
\ Grouped output has a space at every index i with i mod 6 = 5.
: c>grouped ( c -- ) #cipher @ 6 mod 5 = if bl c>cipher then c>cipher ;

: lower ( c -- c' ) dup [char] A [char] Z 1+ within if bl or then ;
: letter? ( c -- flag ) [char] a [char] z 1+ within ;
: numeral? ( c -- flag ) [char] 0 [char] 9 1+ within ;
: mirror ( c -- c' ) [char] a [char] z + swap - ;

: cipher-char ( c -- c' true | false )
  lower
  dup letter? if mirror true exit then
  dup numeral? if true exit then
  drop false ;

\ Stores the cipher of each kept character with xt ( c -- ).
: translate ( c-addr u xt -- c-addr2 u2 )
  0 #cipher !  over room
  -rot bounds ?do  i c@ cipher-char if over execute then  loop
  drop cipher @ #cipher @ ;

: encode ( c-addr u -- c-addr2 u2 ) ['] c>grouped translate ;
: decode ( c-addr u -- c-addr2 u2 ) ['] c>cipher translate ;
