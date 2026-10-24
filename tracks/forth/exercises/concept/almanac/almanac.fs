\ The edition number.
variable edition  3 edition !

\ The seconds in a day, worked out when the word is compiled.
: seconds-per-day ( -- n )
  true abort" implement me" ;

\ The edition as it was when this word was compiled.
: printed-edition ( -- n )
  true abort" implement me" ;

\ The edition as it is now.
: current-edition ( -- n )
  true abort" implement me" ;

\ How many footnotes have been compiled.
variable footnotes

\ Counts one footnote at compile time and compiles nothing; throws -14 outside a definition.
: footnote ( -- )
  true abort" implement me" ; immediate
