\ Every word leaves its text in the system's picture buffer, valid until the next number is formatted.

\ Cents as dollars and cents: 1250 gives 12.50.
: price ( cents -- c-addr u )
  true abort" implement me" ;

\ Like price, with a - in front of a negative amount.
: amount ( cents -- c-addr u )
  true abort" implement me" ;

\ The number padded with zeros to six digits.
: ticket-number ( n -- c-addr u )
  true abort" implement me" ;

\ The number in hexadecimal; the base is unchanged afterwards.
: hex-code ( n -- c-addr u )
  true abort" implement me" ;

\ The number as eight binary digits; the base is unchanged afterwards.
: binary-byte ( n -- c-addr u )
  true abort" implement me" ;
