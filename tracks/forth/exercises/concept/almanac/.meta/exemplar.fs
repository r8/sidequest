\ The edition number.
variable edition  3 edition !

\ The seconds in a day, worked out when the word is compiled.
: seconds-per-day ( -- n )
  [ 24 60 * 60 * ] literal ;

\ The edition as it was when this word was compiled.
: printed-edition ( -- n )
  [ edition @ ] literal ;

\ The edition as it is now.
: current-edition ( -- n )
  edition @ ;

\ How many footnotes have been compiled.
variable footnotes

\ Counts one footnote at compile time and compiles nothing; throws -14 outside a definition.
: footnote ( -- )
  state @ 0= if -14 throw then
  1 footnotes +! ; immediate
