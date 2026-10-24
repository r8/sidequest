\ encode turns each run of a repeated character into its count and the character
\ ("AABBBC" gives "2A3BC"); decode reverses it. Each word leaves its result in its own
\ buffer, owned by the solution and valid until that word's next call, so
\ s" zzz ZZ" encode decode  gives back "zzz ZZ".
: encode ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;

: decode ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
