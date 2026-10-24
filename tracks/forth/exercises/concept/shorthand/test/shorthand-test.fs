require ../lib/test.fs
require ../shorthand.fs

\ The words read from the input, so each test runs them with evaluate on a string: they read the
\ rest of that string. Strings they return point into it, and s" strings in a test stay valid.

test" 1. a long word"  s" letters objection" evaluate 9 assert= ;test
test" 1. a short word"  s" letters no" evaluate 2 assert= ;test
test" 1. spaces before the word are skipped"  s" letters    sustained" evaluate 9 assert= ;test
test" 1. only the next word is read"  s" letters ab 7" evaluate 7 assert= 2 assert= ;test

test" 2. a sentence"  s" sentence The witness paused." evaluate s" The witness paused" assert-str= ;test
test" 2. the text after the full stop runs"
  s" sentence Recess. 10" evaluate 10 assert= s" Recess" assert-str= ;test
test" 2. an empty sentence"  s" sentence ." evaluate nip 0 assert= ;test

test" 3. peek at a number, which then runs"  s" peek 42" evaluate 42 assert= s" 42" assert-str= ;test
test" 3. peek at a parsing word, which then reads the next word"
  s" peek letters abc" evaluate 3 assert= s" letters" assert-str= ;test
test" 3. peek at the end of the input"  s" peek" evaluate nip 0 assert= ;test

test" 4. replay an addition"  0 s" 3 +" 4 replay 12 assert= ;test
test" 4. replay a doubling"  1 s" 2*" 10 replay 1024 assert= ;test
test" 4. replay no times"  7 s" drop" 0 replay 7 assert= ;test
test" 4. replay a note that pushes"  s" 5" 3 replay 5 assert= 5 assert= 5 assert= ;test

test" 5. an abbreviation"  s" shorthand dbl 2 *" evaluate  s" 21 dbl" evaluate 42 assert= ;test
test" 5. an abbreviation used twice"  s" shorthand sq dup *" evaluate  s" 3 sq sq" evaluate 81 assert= ;test
test" 5. the rest of the line is not run when the abbreviation is defined"
  depth >r  s" shorthand five 5" evaluate  depth r> - 0 assert= ;test
test" 5. an abbreviation of abbreviations"
  s" shorthand dbl 2 *" evaluate  s" shorthand quad dbl dbl" evaluate  s" 3 quad" evaluate 12 assert= ;test

\ The source of the definition is overwritten before the abbreviation is used.
create note 32 chars allot
test" 5. the abbreviation keeps its own copy"
  s" shorthand inc 1+" tuck note swap chars move  note swap evaluate
  note 32 bl fill  s" 1 inc" evaluate 2 assert= ;test

end-tests
