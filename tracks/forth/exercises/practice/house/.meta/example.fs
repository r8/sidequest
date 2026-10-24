\ recite returns verses start through end (1 to 12) as one string, one verse per line, lines
\ separated by newlines. The string lives in a buffer the solution owns and stays valid until
\ the next call.

create out 4096 chars allot  variable out#
: >out ( c-addr u -- ) tuck out out# @ chars + swap chars move out# +! ;

\ Tables of counted strings laid end to end; nth picks one out, counting from 1.
: phrase" ( "text<quote>" -- ) [char] " parse dup c, here swap dup chars allot move ;
: nth ( addr n -- c-addr u ) 1- 0 ?do count chars + loop count ;

\ What each verse adds, and what that thing did to the one before it.
create things
  phrase" house that Jack built" phrase" malt" phrase" rat" phrase" cat" phrase" dog"
  phrase" cow with the crumpled horn" phrase" maiden all forlorn"
  phrase" man all tattered and torn" phrase" priest all shaven and shorn"
  phrase" rooster that crowed in the morn" phrase" farmer sowing his corn"
  phrase" horse and the hound and the horn"
create deeds
  phrase" " phrase" lay in" phrase" ate" phrase" killed" phrase" worried" phrase" tossed"
  phrase" milked" phrase" kissed" phrase" married" phrase" woke" phrase" kept"
  phrase" belonged to"

: the ( n -- ) s" the " >out things swap nth >out ;
: that ( n -- ) s"  that " >out deeds swap nth >out s"  " >out ;

: verse ( n -- )
  s" This is " >out
  begin dup 1 > while dup the dup that 1- repeat
  the s" ." >out ;

: recite ( start end -- c-addr u )
  0 out# !  1+ over ?do
    i over <> if s\" \n" >out then i verse
  loop drop  out out# @ ;
