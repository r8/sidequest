\ Each word leaves its sign in a buffer it owns, valid until that word is called again.
\ A sign holds at most 80 characters; a longer result is cut off after the 80th.

80 constant board-size

\ A board is a cell with the length of its text, then room for board-size characters.
create shouted  0 , board-size chars allot
create framed-board  0 , board-size chars allot
create repeated-board  0 , board-size chars allot
create spaced-board  0 , board-size chars allot

: text ( board -- c-addr u )  dup cell+ swap @ ;
: wipe ( board -- )  0 swap ! ;
: room ( board -- u )  board-size swap @ - ;
: end-of ( board -- c-addr )  text chars + ;

\ Appends as much of the string as fits.
: +text ( c-addr u board -- )
  tuck room min  over end-of swap  rot over swap +!  move ;

\ Appends a character if it fits.
: +char ( c board -- )
  dup room 0> if  dup end-of rot swap c!  1 swap +!  else 2drop then ;

: upper ( c -- c' )
  dup [char] a [char] z 1+ within if [char] a [char] A - - then ;

\ The text with every lower-case letter in upper case.
: shout ( c-addr u -- c-addr2 u )
  shouted wipe  bounds ?do  i c@ upper shouted +char  loop  shouted text ;

\ The text between "* " and " *".
: framed ( c-addr u -- c-addr2 u2 )
  framed-board wipe  s" * " framed-board +text  framed-board +text  s"  *" framed-board +text
  framed-board text ;

\ n copies of the text, separated by single spaces.
: repeated ( c-addr u n -- c-addr2 u2 )
  repeated-board wipe
  0 ?do  i if bl repeated-board +char then  2dup repeated-board +text  loop 2drop
  repeated-board text ;

\ The text with a space between every two characters.
: spaced-out ( c-addr u -- c-addr2 u2 )
  spaced-board wipe
  dup if  over c@ spaced-board +char  1 /string  then
  bounds ?do  bl spaced-board +char  i c@ spaced-board +char  loop
  spaced-board text ;
