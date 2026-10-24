\ to-rna leaves the RNA complement in a buffer it owns, valid until the next call.
\ A character that isn't a DNA nucleotide (G, C, T, A) throws -24 (invalid numeric argument).
\ The buffer is allocated memory, resized to fit each strand.
variable strand  1 allocate throw strand !
: room ( u -- ) chars 1 max  strand @ swap resize throw  strand ! ;

: complement ( c -- c' )
  case
    [char] G of [char] C endof
    [char] C of [char] G endof
    [char] T of [char] A endof
    [char] A of [char] U endof
    -24 throw
  endcase ;

: to-rna ( c-addr u -- c-addr2 u2 )
  dup room
  tuck 0 ?do  dup i chars + c@ complement  strand @ i chars + c!  loop
  drop strand @ swap ;
