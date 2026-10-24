\ recite returns verses start through end (1 to 8) as one string: lines separated by newlines,
\ verses separated by an empty line. The string lives in a buffer the solution owns and stays
\ valid until the next call.
: recite ( start end -- c-addr u )
  true abort" implement me" ;
