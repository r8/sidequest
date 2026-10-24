\ rotate shifts every letter n places along the alphabet (0 <= n <= 26), keeping its case;
\ other characters pass through. The result is in a buffer the solution owns, valid until
\ the next call:  s" OMG" 5 rotate  gives "TRL".
: rotate ( c-addr u n -- c-addr2 u2 )
  true abort" implement me" ;
