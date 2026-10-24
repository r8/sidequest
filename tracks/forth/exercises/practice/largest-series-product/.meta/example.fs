\ The largest product of `span` adjacent digits in the string of digits.
\ Throw -24 (invalid numeric argument) when the span is negative, when it exceeds the string's
\ length, or when the string contains anything but digits.
: digit? ( c -- flag ) [char] 0 [char] 9 1+ within ;
: digits? ( c-addr u -- flag )
  bounds ?do  i c@ digit? 0= if false unloop exit then  loop true ;

: product ( c-addr u -- n ) 1 -rot bounds ?do i c@ [char] 0 - * loop ;

: check ( c-addr u span -- c-addr u span )
  dup 0< if -24 throw then
  2dup < if -24 throw then
  >r 2dup digits? 0= if -24 throw then r> ;

: largest-product ( c-addr u span -- n )
  check tuck - 1+  0 swap 0 ?do  ( c-addr span max )
    2 pick i chars +  2 pick product  max
  loop nip nip ;
