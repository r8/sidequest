\ Resistor band colors and their values:
\   black 0, brown 1, red 2, orange 3, yellow 4, green 5, blue 6, violet 7, grey 8, white 9.
\ color-code takes a color's name:  s" brown" color-code  ( -- 1 )
\ It throws -24 (invalid numeric argument) for a name that isn't one of the ten colors.

\ All ten colors in value order, separated by single spaces ("black brown red …").
\ The string is in memory the solution owns.
: colors ( -- c-addr u )
  s" black brown red orange yellow green blue violet grey white" ;

\ Split off the first space-separated word.
: split ( c-addr u -- rest-addr rest-u word-addr word-u )
  2dup bl scan  2dup 2>r  nip -  2r> dup if 1 /string then  2swap ;

\ The position of the word c-addr u in the space-separated list; -24 throw when it's absent.
: index-of ( c-addr u list-addr list-u -- n )
  0 >r  begin dup while
    split 2>r 2over 2r> compare 0= if 2drop 2drop r> exit then
    r> 1+ >r
  repeat  r> drop -24 throw ;

: color-code ( c-addr u -- n ) colors index-of ;
