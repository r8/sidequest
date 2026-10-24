\ A moment is six numbers on the stack: year month day hour minute second, as in
\ 2015 1 24 22 0 0 for 2015-01-24T22:00:00. add leaves the moment one gigasecond
\ (10^9 seconds) later, in the same shape.
: add ( y m d h min s -- y' m' d' h' min' s' )
  true abort" implement me" ;
