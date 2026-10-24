\ Reads the next word of the input and leaves its length.
: letters ( "word" -- n )
  parse-name nip ;

\ Reads the input up to the next full stop and leaves the text before it.
: sentence ( "text<.>" -- c-addr u )
  [char] . parse ;

\ Leaves the next word of the input without consuming it.
: peek ( "word" -- c-addr u )
  >in @ >r  parse-name  r> >in ! ;

\ Interprets the source c-addr u, n times. The string waits on the return stack while the text runs,
\ so the text finds the stack as it was below the string.
: replay ( i*x c-addr u n -- j*x )
  0 ?do  2dup 2>r evaluate 2r>  loop  2drop ;

\ The rest of the current line, which is then skipped.
: rest-of-line ( "text" -- c-addr u )
  source >in @ /string  dup >in +! ;

\ Defines abbr as a word that interprets a copy of the rest of the line, kept in its data as a
\ length followed by the characters.
: shorthand ( "abbr" "expansion" -- )
  create  rest-of-line  dup c,  here swap dup chars allot move
  does> ( i*x -- j*x ) count evaluate ;
