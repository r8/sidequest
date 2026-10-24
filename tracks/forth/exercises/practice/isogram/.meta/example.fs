\ True when no letter occurs more than once, ignoring case; spaces and hyphens may repeat.
: letter? ( c -- flag ) toupper [char] A [char] Z 1+ within ;
: letter-bit ( c -- mask ) toupper [char] A - 1 swap lshift ;

\ Add c to the set of seen letters; false when it was already there.
: see ( seen c -- seen' flag )
  dup letter? 0= if drop true exit then
  letter-bit 2dup and 0= >r or r> ;

: isogram? ( c-addr u -- flag )
  0 -rot bounds ?do  i c@ see 0= if drop false unloop exit then  loop
  drop true ;
