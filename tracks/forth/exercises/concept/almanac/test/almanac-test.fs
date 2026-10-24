require ../lib/test.fs
require ../almanac.fs

\ The tests of footnote compile definitions as they run, with evaluate. If footnote throws in the
\ middle of a definition, evaluate stops with the interpreter still compiling, and the rest of this
\ file would be compiled into that broken definition instead of being run. compile-source switches
\ back to interpreting before passing the throw on.
: compile-source ( i*x c-addr u -- j*x )
  ['] evaluate catch ?dup if  postpone [  throw  then ;

test" 1. seconds in a day"  seconds-per-day 86400 assert= ;test
test" 1. seconds in a week"  seconds-per-day 7 * 604800 assert= ;test

test" 2. the printed edition is the edition when it was compiled"
  9 edition !  printed-edition  3 edition !  3 assert= ;test
test" 2. the current edition follows changes"
  9 edition !  current-edition  3 edition !  9 assert= ;test
test" 2. both editions before any change"  printed-edition 3 assert=  current-edition 3 assert= ;test

test" 3. two footnotes in one entry"
  footnotes @  s" : tide-table ( -- n ) footnote 12 footnote ;" compile-source  footnotes @ swap - 2 assert= ;test
test" 3. a footnote compiles nothing"
  s" : tide-table ( -- n ) footnote 12 footnote ;  tide-table" compile-source 12 assert= ;test
test" 3. footnotes in several entries add up"
  footnotes @
  s" : sunrise ( -- ) footnote ;  : sunset ( -- ) footnote footnote ;  : moon ( -- ) ;" compile-source
  footnotes @ swap - 3 assert= ;test
test" 3. running an entry adds no footnotes"
  s" : sunrise ( -- n ) 6 footnote ;" compile-source
  footnotes @  s" sunrise sunrise 2drop" evaluate  footnotes @ swap - 0 assert= ;test

test" 4. a footnote outside a definition"  ['] footnote -14 assert-xt-throws ;test
test" 4. a refused footnote is not counted"
  footnotes @  ['] footnote -14 assert-xt-throws  footnotes @ swap - 0 assert= ;test

end-tests
