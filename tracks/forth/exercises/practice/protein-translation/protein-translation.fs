\ proteins translates an RNA strand codon by codon, up to the first STOP codon, and returns the
\ protein names as one string separated by single spaces: s" AUGUUUUGG" proteins gives
\ "Methionine Phenylalanine Tryptophan". The string lives in a buffer the solution owns and stays
\ valid until the next call.
\ Throw -24 (invalid numeric argument) for an invalid codon, including a trailing partial one
\ that translation reaches.
: proteins ( c-addr u -- c-addr' u' )
  true abort" implement me" ;
