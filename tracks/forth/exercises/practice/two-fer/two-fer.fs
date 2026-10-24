\ two-fer leaves its sentence in a buffer it owns, valid until the next call.
\ An empty name (0 0, or s" ") means no name was given:
\   0 0 two-fer          gives "One for you, one for me."
\   s" Alice" two-fer    gives "One for Alice, one for me."
: two-fer ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
