\ slices returns every run of n consecutive characters of the series, in order, as one string
\ of slices separated by single spaces: s" 9142" 2 slices gives "91 14 42". The string lives in
\ a buffer the solution owns and stays valid until the next call.
\ Throw -24 (invalid numeric argument) when the series is empty or n is not 1 to its length.

\ The buffer is allocated memory, resized for each call to the u-n+1 slices and their spaces.
variable out  1 allocate throw out !  variable out#
: room ( u -- ) chars 1 max  out @ swap resize throw  out ! ;
: >out ( c-addr u -- ) tuck out @ out# @ chars + swap chars move out# +! ;

\ n must be 1 to u, which also rules out an empty series.
: check ( u n -- ) swap 1+ 1 swap within 0= if -24 throw then ;

: slices ( c-addr u n -- c-addr' u' )
  2dup check  0 out# !  2dup tuck - 1+ swap 1+ * room
  swap over - 1+ 0 do       ( c-addr n )
    i if s"  " >out then  over i chars + over >out
  loop 2drop  out @ out# @ ;
