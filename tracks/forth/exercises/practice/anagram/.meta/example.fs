\ find-anagrams takes the subject word and the candidates, one string of words separated by single
\ spaces, and returns the candidates that are anagrams of the subject in the same form, in their
\ original order and spelling:
\   s" solemn" s" lemons cherry melons" find-anagrams  ( -- c-addr u )  \ "lemons melons"
\ Letters compare case-insensitively, and a word is not an anagram of itself. No matches gives an
\ empty string. The result lives in a buffer of the solution, valid until the next call.

create tallies 256 cells allot
\ The matches, in allocated memory resized for each call: they are never longer than the candidates.
variable matches  1 allocate throw matches !  variable #matches
: room ( u -- ) chars 1 max  matches @ swap resize throw  matches ! ;
: >matches ( c-addr u -- ) tuck matches @ #matches @ chars + swap chars move  #matches +! ;

: lower ( char -- char' ) dup [char] A [char] Z 1+ within bl and + ;

\ Adds n to the tally of every letter of the word.
: tally ( c-addr u n -- ) -rot bounds ?do  dup i c@ lower cells tallies + +!  loop drop ;

: balanced? ( -- flag ) true  256 0 do tallies i cells + @ 0= and loop ;

: same-letters? ( c-addr1 u1 c-addr2 u2 -- flag )
  tallies 256 cells erase  -1 tally  1 tally  balanced? ;

: anagram? ( c-addr1 u1 c-addr2 u2 -- flag )
  2over 2over capscompare 0= if 2drop 2drop false exit then
  same-letters? ;

\ Splits off the first space-separated word.
: next-word ( c-addr u -- c-addr' u' word-addr word-u )
  bl skip  2dup bl scan  2swap 2 pick - ;

: +match ( c-addr u -- ) #matches @ if s"  " >matches then  >matches ;

2variable subject

: consider ( c-addr u -- ) 2dup subject 2@ anagram? if +match else 2drop then ;

: find-anagrams ( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 )
  2swap subject 2!  0 #matches !  dup room
  begin dup while next-word consider repeat 2drop  matches @ #matches @ ;
