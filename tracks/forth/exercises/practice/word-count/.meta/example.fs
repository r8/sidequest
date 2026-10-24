\ count-words counts the words of a sentence; occurrences then looks a word up and #words gives the
\ number of distinct words, so the counts form a map from word to count:
\   s" one fish two fish" count-words  s" fish" occurrences  ( -- 2 )  #words  ( -- 3 )
\ A word is a run of letters, digits and apostrophes, without apostrophes at either end ("can't" is
\ one word, "'large'" is "large"). Words are case-insensitive: keys are lowercase, and occurrences
\ takes a lowercase word, giving 0 for one the sentence did not contain. The counts stay until the
\ next count-words.

\ The sentence is copied, lowercased, into allocated memory resized for each sentence. Each
\ distinct word is a record of three cells: its length and address in that copy, and its count.
\ A word takes a character and a separator, so a sentence of u characters has at most (u+1)/2.
variable sentence  1 allocate throw sentence !
variable records  1 allocate throw records !
variable #distinct

: renew ( var u -- ) 1 max  over @ swap resize throw  swap ! ;

3 cells constant /record
: record ( i -- addr ) /record * records @ + ;
: slot ( i -- c-addr u ) record 2@ ;
: tally ( i -- addr ) record 2 cells + ;

: lower ( char -- char' ) dup [char] A [char] Z 1+ within bl and + ;
: alnum? ( char -- flag )
  dup [char] a [char] z 1+ within  swap [char] 0 [char] 9 1+ within or ;
: word-char? ( char -- flag ) dup [char] ' = swap alnum? or ;

\ The sentence, lowercased, with every separator turned into a space.
: normalize ( c-addr u -- c-addr' u' )
  sentence over chars renew
  tuck 0 ?do
    dup i chars + c@ lower  dup word-char? 0= if drop bl then  sentence @ i chars + c!
  loop drop  sentence @ swap ;

: leading-quote? ( c-addr u -- c-addr u flag ) dup if over c@ [char] ' = else false then ;
: trailing-quote? ( c-addr u -- c-addr u flag ) dup if 2dup + 1- c@ [char] ' = else false then ;
: unquote ( c-addr u -- c-addr' u' )
  begin leading-quote? while 1 /string repeat
  begin trailing-quote? while 1- repeat ;

\ Splits off the first space-separated word.
: next-word ( c-addr u -- c-addr' u' word-addr word-u )
  bl skip  2dup bl scan  2swap 2 pick - ;

: find-word ( c-addr u -- i true | false )
  #distinct @ 0 ?do
    2dup i slot compare 0= if 2drop i true unloop exit then
  loop 2drop false ;

: new-word ( c-addr u -- i )
  #distinct @ >r  r@ record 2!  0 r@ tally !  1 #distinct +!  r> ;

: add-word ( c-addr u -- )
  unquote dup 0= if 2drop exit then
  2dup find-word if nip nip else new-word then  1 swap tally +! ;

: count-words ( c-addr u -- )
  0 #distinct !  records over 1+ 2/ /record * renew  normalize
  begin dup while next-word add-word repeat 2drop ;

: occurrences ( c-addr u -- n ) find-word if tally @ else 0 then ;

: #words ( -- n ) #distinct @ ;
