\ Resistor band colors and their values:
\   black 0, brown 1, red 2, orange 3, yellow 4, green 5, blue 6, violet 7, grey 8, white 9.
\ color-code takes a color's name:  s" brown" color-code  ( -- 1 )
\ It throws -24 (invalid numeric argument) for a name that isn't one of the ten colors.
: color-code ( c-addr u -- n )
  true abort" implement me" ;

\ All ten colors in value order, separated by single spaces ("black brown red …").
\ The string is in memory the solution owns.
: colors ( -- c-addr u )
  true abort" implement me" ;
