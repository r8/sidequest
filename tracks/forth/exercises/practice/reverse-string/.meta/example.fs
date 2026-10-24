\ reverse leaves the reversed string in a buffer it owns, valid until the next call.
\ Strings are ASCII: one character per byte.

\ The buffer is allocated memory, resized to fit each string.
variable reversed  1 allocate throw reversed !
: room ( u -- ) chars 1 max  reversed @ swap resize throw  reversed ! ;

\ Copies forwards through the input while filling the buffer backwards from its end.
: reverse ( c-addr u -- c-addr2 u2 )
  dup room
  dup >r  reversed @ over chars +  -rot  ( end c-addr u )
  bounds ?do  1 chars -  i c@ over c!  loop
  drop reversed @ r> ;
