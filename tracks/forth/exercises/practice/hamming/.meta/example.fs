\ The number of positions at which two DNA strands differ.
\ Throw -24 (invalid numeric argument) when the strands differ in length.
: differs? ( c-addr1 c-addr2 i -- flag ) chars tuck + c@ -rot + c@ <> ;

: distance ( c-addr1 u1 c-addr2 u2 -- n )
  rot over <> if -24 throw then  ( c-addr1 c-addr2 u )
  0 swap 0 ?do  2 pick 2 pick i differs? -  loop nip nip ;
