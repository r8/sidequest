\ Reads the next word of the input and leaves its length.
: letters ( "word" -- n )
  true abort" implement me" ;

\ Reads the input up to the next full stop and leaves the text before it.
: sentence ( "text<.>" -- c-addr u )
  true abort" implement me" ;

\ Leaves the next word of the input without consuming it.
: peek ( "word" -- c-addr u )
  true abort" implement me" ;

\ Interprets the source c-addr u, n times.
: replay ( i*x c-addr u n -- j*x )
  true abort" implement me" ;

\ Defines abbr as a word that interprets a copy of the rest of the line.
: shorthand ( "abbr" "expansion" -- )
  true abort" implement me" ;
