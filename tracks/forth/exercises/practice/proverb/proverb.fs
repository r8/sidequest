\ The pieces come in as one string of words separated by single spaces, "nail shoe horse".
\ The proverb comes back as one string, its lines separated by newlines, in a buffer the solution
\ owns; it stays valid until the next call. No pieces make an empty proverb.
: recite ( c-addr u -- c-addr' u' )
  true abort" implement me" ;
