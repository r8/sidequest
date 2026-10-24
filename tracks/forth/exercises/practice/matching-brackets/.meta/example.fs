\ True when every (, [ and { in the string is closed by its partner in the right order.
\ Other characters are ignored.

\ A stack of the closing brackets still expected, allocated for each string: at most one per character.
variable expected  variable #expected

: push ( c -- ) expected @ #expected @ chars + c!  1 #expected +! ;
: pop ( -- c | 0 )
  #expected @ 0= if 0 exit then
  -1 #expected +!  expected @ #expected @ chars + c@ ;

: partner ( c -- c' | 0 )
  case  [char] ( of [char] ) endof  [char] [ of [char] ] endof  [char] { of [char] } endof
    0 swap  endcase ;
: closing? ( c -- flag ) s" )]}" rot scan nip 0<> ;

\ False when c closes a bracket that isn't the innermost open one.
: bracket ( c -- flag )
  dup partner ?dup if nip push true exit then
  dup closing? if pop = else drop true then ;

: balanced? ( c-addr u -- flag )
  bounds ?do  i c@ bracket 0= if false unloop exit then  loop
  #expected @ 0= ;

: paired? ( c-addr u -- flag )
  dup 1 max chars allocate throw expected !  0 #expected !
  balanced?  expected @ free throw ;
