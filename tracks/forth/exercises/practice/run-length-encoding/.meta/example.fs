\ encode turns each run of a repeated character into its count and the character
\ ("AABBBC" gives "2A3BC"); decode reverses it. Each word leaves its result in its own
\ buffer, owned by the solution and valid until that word's next call, so
\ s" zzz ZZ" encode decode  gives back "zzz ZZ".

\ A text buffer is three cells: the length of its text, the room it has, and the address of the
\ allocated memory holding the characters, which grows as needed.
: text-buffer ( "name" -- ) create 0 , 16 , 16 chars allocate throw , ;
: text ( buf -- c-addr u ) dup 2 cells + @ swap @ ;
\ Makes room for n more characters, at least doubling the room when it grows.
: grow ( n buf -- )
  tuck @ +  over cell+ @ over < if  ( buf needed )
    over cell+ @ 2* max  2dup swap cell+ !
    chars over 2 cells + @ swap resize throw  swap 2 cells + !
  else 2drop then ;
: c+text ( c buf -- ) 1 over grow  tuck text chars + c!  1 swap +! ;
: s+text ( c-addr u buf -- ) -rot bounds ?do i c@ over c+text loop drop ;
: n*c+text ( n c buf -- ) rot 0 ?do 2dup c+text loop 2drop ;

text-buffer encoded
text-buffer decoded

\ How many times the first character repeats at the start of the string (u > 0).
: run-length ( c-addr u -- n )
  dup >r  over c@ -rot  ( c c-addr u )
  0 ?do  2dup i chars + c@ <> if 2drop i unloop rdrop exit then  loop
  2drop r> ;

: count+text ( n buf -- ) over 1 > if >r 0 <# #s #> r> s+text else 2drop then ;

: encode ( c-addr u -- c-addr2 u2 )
  0 encoded !
  begin dup while
    2dup run-length  dup encoded count+text  2 pick c@ encoded c+text  /string
  repeat 2drop
  encoded text ;

: numeral? ( c -- flag ) [char] 0 [char] 9 1+ within ;

\ The count read so far stays on the stack; a missing count means 1.
: decode ( c-addr u -- c-addr2 u2 )
  0 decoded !
  0 -rot bounds ?do  ( count )
    i c@ numeral? if  10 * i c@ [char] 0 - +  else  1 max i c@ decoded n*c+text 0  then
  loop drop
  decoded text ;
