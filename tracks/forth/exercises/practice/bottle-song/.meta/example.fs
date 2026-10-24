\ recite returns take-down verses, counting down from start-bottles (at most ten), as one
\ string: lines separated by newlines, verses separated by an empty line. The string lives in a
\ buffer the solution owns and stays valid until the next call.

create out 4096 chars allot  variable out#
: >out ( c-addr u -- ) tuck out out# @ chars + swap chars move out# +! ;
: line-break ( -- ) s\" \n" >out ;

\ Tables of counted strings laid end to end; nth picks one out, counting from 0.
: phrase" ( "text<quote>" -- ) [char] " parse dup c, here swap dup chars allot move ;
: nth ( addr n -- c-addr u ) 0 ?do count chars + loop count ;

create numbers
  phrase" no" phrase" one" phrase" two" phrase" three" phrase" four" phrase" five"
  phrase" six" phrase" seven" phrase" eight" phrase" nine" phrase" ten"

: capitalize ( c-addr -- ) dup c@ toupper swap c! ;
: bottles ( n -- )
  dup numbers swap nth >out
  s"  green bottle" >out 1 <> if s" s" >out then ;
: capital-bottles ( n -- ) out out# @ chars + swap bottles capitalize ;

: on-the-wall ( n -- ) capital-bottles s\"  hanging on the wall,\n" >out ;
: verse ( n -- )
  dup on-the-wall dup on-the-wall
  s\" And if one green bottle should accidentally fall,\n" >out
  s" There'll be " >out 1- bottles s"  hanging on the wall." >out ;

: recite ( start-bottles take-down -- c-addr u )
  0 out# !  0 ?do
    i if line-break line-break then dup i - verse
  loop drop  out out# @ ;
