\ clean leaves the ten-digit NANP number in a buffer it owns, valid until the next call:
\   s" +1 (223) 456-7890" clean  gives "2234567890"
\ Spaces and the punctuation + ( ) - . are allowed and dropped. An invalid number throws -24
\ (invalid numeric argument); the canonical errors are:
\   "must not be fewer than 10 digits", "must not be greater than 11 digits",
\   "11 digits must start with 1", "letters not permitted", "punctuations not permitted",
\   "area code cannot start with zero/one", "exchange code cannot start with zero/one".
: clean ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
