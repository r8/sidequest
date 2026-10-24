\ recite returns take-down verses, counting down from start-bottles (at most ten), as one
\ string: lines separated by newlines, verses separated by an empty line. The string lives in a
\ buffer the solution owns and stays valid until the next call.
: recite ( start-bottles take-down -- c-addr u )
  true abort" implement me" ;
