\ slices returns every run of n consecutive characters of the series, in order, as one string
\ of slices separated by single spaces: s" 9142" 2 slices gives "91 14 42". The string lives in
\ a buffer the solution owns and stays valid until the next call.
\ Throw -24 (invalid numeric argument) when the series is empty or n is not 1 to its length.
: slices ( c-addr u n -- c-addr' u' )
  true abort" implement me" ;
