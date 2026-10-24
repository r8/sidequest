\ recite returns verses start through end (1 to 8) as one string: lines separated by newlines,
\ verses separated by an empty line. The string lives in a buffer the solution owns and stays
\ valid until the next call.

create out 4096 chars allot  variable out#
: >out ( c-addr u -- ) tuck out out# @ chars + swap chars move out# +! ;
: line-break ( -- ) s\" \n" >out ;

\ Tables of counted strings laid end to end; nth picks one out, counting from 1.
: phrase" ( "text<quote>" -- ) [char] " parse dup c, here swap dup chars allot move ;
: nth ( addr n -- c-addr u ) 1- 0 ?do count chars + loop count ;

create animals
  phrase" fly" phrase" spider" phrase" bird" phrase" cat"
  phrase" dog" phrase" goat" phrase" cow" phrase" horse"
create remarks
  phrase" "
  phrase" It wriggled and jiggled and tickled inside her."
  phrase" How absurd to swallow a bird!"
  phrase" Imagine that, to swallow a cat!"
  phrase" What a hog, to swallow a dog!"
  phrase" Just opened her throat and swallowed a goat!"
  phrase" I don't know how she swallowed a cow!"
  phrase" She's dead, of course!"

8 constant last-animal
: animal ( n -- c-addr u ) animals swap nth ;
: remark ( n -- c-addr u ) remarks swap nth ;

: swallowed ( n -- ) s" I know an old lady who swallowed a " >out animal >out s" ." >out ;
\ The spider is caught "that wriggled …": its remark without "It" and the full stop.
: that-wriggled ( -- ) s"  that" >out 2 remark 2 /string 1- >out ;
: to-catch ( n -- )
  s" She swallowed the " >out dup animal >out
  s"  to catch the " >out 1- dup animal >out
  2 = if that-wriggled then s" ." >out ;
: chain ( n -- ) begin dup 1 > while dup to-catch line-break 1- repeat drop ;
: perhaps ( -- ) s" I don't know why she swallowed the fly. Perhaps she'll die." >out ;

: verse ( n -- )
  dup swallowed line-break
  dup last-animal = if remark >out exit then
  dup 1 > if dup remark >out line-break then
  chain perhaps ;

: recite ( start end -- c-addr u )
  0 out# !  1+ over ?do
    i over <> if line-break line-break then i verse
  loop drop  out out# @ ;
