require ../lib/test.fs
require ../greet.fs

\ A comment with ;test and a "string" that must not confuse extraction.
test" greets"
  ." noisy output" cr ." second line"
  greet s" Hello, you!" assert-str= ;test
test" doubles"  21 double 42 assert= ;test

end-tests
