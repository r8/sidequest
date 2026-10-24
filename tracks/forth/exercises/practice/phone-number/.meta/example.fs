\ clean leaves the ten-digit NANP number in a buffer it owns, valid until the next call:
\   s" +1 (223) 456-7890" clean  gives "2234567890"
\ Spaces and the punctuation + ( ) - . are allowed and dropped. An invalid number throws -24
\ (invalid numeric argument); the canonical errors are:
\   "must not be fewer than 10 digits", "must not be greater than 11 digits",
\   "11 digits must start with 1", "letters not permitted", "punctuations not permitted",
\   "area code cannot start with zero/one", "exchange code cannot start with zero/one".
\ More than 11 digits is never valid, so the buffer holds 11.
create digits 11 chars allot  variable #digits

: ?invalid ( flag -- ) if -24 throw then ;
: c>digits ( c -- ) #digits @ 11 = ?invalid  digits #digits @ chars + c!  1 #digits +! ;

: numeral? ( c -- flag ) [char] 0 [char] 9 1+ within ;
: separator? ( c -- flag ) >r s" +()-. " r> scan nip 0<> ;

: collect ( c-addr u -- c-addr2 u2 )
  0 #digits !
  bounds ?do
    i c@ dup numeral? if c>digits else separator? 0= ?invalid then
  loop
  digits #digits @ ;

: -country-code ( c-addr u -- c-addr' u' )
  dup 11 = if  over c@ [char] 1 <> ?invalid  1 /string  then ;

\ Area and exchange codes start with 2-9.
: ?code ( c-addr offset -- ) chars + c@ [char] 2 < ?invalid ;

: clean ( c-addr u -- c-addr2 u2 )
  collect -country-code
  dup 10 <> ?invalid
  over 0 ?code  over 3 ?code ;
