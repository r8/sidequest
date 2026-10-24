\ Throw -24 (invalid numeric argument) unless n is positive.
: next ( n -- n' ) dup 1 and if 3 * 1+ else 2/ then ;

: steps ( n -- steps )
  dup 1 < if -24 throw then
  0 swap  begin dup 1 <> while  next swap 1+ swap  repeat  drop ;
