\ recite returns verses start through end (1 to 12) as one string, one verse per line, lines
\ separated by newlines. The string lives in a buffer the solution owns and stays valid until
\ the next call.
: recite ( start end -- c-addr u )
  true abort" implement me" ;
