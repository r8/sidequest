\ Each word leaves its sign in a buffer it owns, valid until that word is called again.
\ A sign holds at most 80 characters; a longer result is cut off after the 80th.

\ The text with every lower-case letter in upper case.
: shout ( c-addr u -- c-addr2 u )
  true abort" implement me" ;

\ The text between "* " and " *".
: framed ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;

\ n copies of the text, separated by single spaces.
: repeated ( c-addr u n -- c-addr2 u2 )
  true abort" implement me" ;

\ The text with a space between every two characters.
: spaced-out ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
