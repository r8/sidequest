\ The key a b follows the string: s" yes" 5 7 encode  gives "xbt".
\ encode and decode leave their result in a buffer the solution owns, valid until the next
\ call to either word. Letters are lowercased and enciphered, digits pass through, everything
\ else is dropped; encode groups its output in blocks of five separated by spaces.
\ A key whose a isn't coprime with 26 ("a and m must be coprime.") throws -24
\ (invalid numeric argument).
26 constant m

\ The buffer is allocated memory, resized for each string: grouping adds at most one space for
\ every five characters, so twice the input's length is always enough.
variable cipher  1 allocate throw cipher !  variable #cipher
: room ( u -- ) 2* chars 1 max  cipher @ swap resize throw  cipher ! ;

: c>cipher ( c -- ) cipher @ #cipher @ chars + c!  1 #cipher +! ;
\ Grouped output has a space at every index i with i mod 6 = 5.
: c>grouped ( c -- ) #cipher @ 6 mod 5 = if bl c>cipher then c>cipher ;

: gcd ( a b -- n ) begin ?dup while tuck mod repeat ;
: coprime ( a -- a ) dup m gcd 1 <> if -24 throw then ;
: inverse ( a -- a' ) 1 begin 2dup * m mod 1 <> while 1+ repeat nip ;

\ Both directions map a letter's index x to (mul * x + add) mod m.
variable mul  variable add

: encode-key ( a b -- ) swap coprime mul ! add ! ;
\ Decoding is x = a' * (y - b) = a' * y + (m - a' * b mod m).
: decode-key ( a b -- ) swap coprime inverse tuck * m mod m swap - add ! mul ! ;

: lower ( c -- c' ) dup [char] A [char] Z 1+ within if bl or then ;
: letter? ( c -- flag ) [char] a [char] z 1+ within ;
: numeral? ( c -- flag ) [char] 0 [char] 9 1+ within ;
: shift ( c -- c' ) [char] a - mul @ * add @ + m mod [char] a + ;

: cipher-char ( c -- c' true | false )
  lower
  dup letter? if shift true exit then
  dup numeral? if true exit then
  drop false ;

\ Stores the cipher of each kept character with xt ( c -- ).
: translate ( c-addr u xt -- c-addr2 u2 )
  0 #cipher !  over room
  -rot bounds ?do  i c@ cipher-char if over execute then  loop
  drop cipher @ #cipher @ ;

: encode ( c-addr u a b -- c-addr2 u2 ) encode-key ['] c>grouped translate ;
: decode ( c-addr u a b -- c-addr2 u2 ) decode-key ['] c>cipher translate ;
