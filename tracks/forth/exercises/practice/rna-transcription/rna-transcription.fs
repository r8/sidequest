\ to-rna leaves the RNA complement in a buffer it owns, valid until the next call.
\ A character that isn't a DNA nucleotide (G, C, T, A) throws -24 (invalid numeric argument).
: to-rna ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
