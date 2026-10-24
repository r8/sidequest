\ The key a b follows the string: s" yes" 5 7 encode  gives "xbt".
\ encode and decode leave their result in a buffer the solution owns, valid until the next
\ call to either word. Letters are lowercased and enciphered, digits pass through, everything
\ else is dropped; encode groups its output in blocks of five separated by spaces.
\ A key whose a isn't coprime with 26 ("a and m must be coprime.") throws -24
\ (invalid numeric argument).
: encode ( c-addr u a b -- c-addr2 u2 )
  true abort" implement me" ;

: decode ( c-addr u a b -- c-addr2 u2 )
  true abort" implement me" ;
