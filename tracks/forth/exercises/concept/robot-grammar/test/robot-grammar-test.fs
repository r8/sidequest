require ../lib/test.fs
require ../robot-grammar.fs

\ Each test compiles an anonymous definition that uses the words, with evaluate, and runs it. If a
\ word throws in the middle of a definition, evaluate stops with the interpreter still compiling,
\ and the rest of this file would be compiled into that broken definition instead of being run.
\ compile-source switches back to interpreting before passing the throw on.
: compile-source ( i*x c-addr u -- j*x )
  ['] evaluate catch ?dup if  postpone [  throw  then ;

\ Whether the word named c-addr u is immediate: its compilation behaviour is to execute it.
: immediate? ( c-addr u -- flag ) find-name name>comp nip ['] execute = ;

test" 1. squaring seven"  s" :noname 7 squared ;" compile-source execute 49 assert= ;test
test" 1. squaring a negative number"  s" :noname ( n -- n*n ) squared ;" compile-source -4 swap execute 16 assert= ;test
test" 1. squared is a macro"  s" squared" immediate? assert-true  s" :noname 3 squared ;" compile-source execute 9 assert= ;test

test" 2. unless runs its code when the flag is false"
  s" :noname ( flag -- n ) 5 swap unless drop 1 then ;" compile-source  false swap execute 1 assert= ;test
test" 2. unless skips its code when the flag is true"
  s" :noname ( flag -- n ) 5 swap unless drop 1 then ;" compile-source  true swap execute 5 assert= ;test
test" 2. unless with else"
  s" :noname ( flag -- n ) unless 1 else 0 then ;" compile-source
  dup false swap execute 1 assert=  true swap execute 0 assert= ;test

test" 3. twice one-plus"  s" :noname 5 twice 1+ ;" compile-source execute 7 assert= ;test
test" 3. twice doubling"  s" :noname 3 twice 2* ;" compile-source execute 12 assert= ;test
test" 3. the word after twice is not compiled a third time"
  s" :noname 1 twice 1+ 10 ;" compile-source execute 10 assert= 3 assert= ;test

test" 4. three steps"  0 steps !  s" :noname step step step ;" compile-source execute 3 assert= 2 assert= 1 assert= ;test
test" 4. the steps are numbered when compiled, not when run"
  0 steps !  s" :noname step step ;" compile-source  dup execute 2drop  execute 2 assert= 1 assert= ;test
test" 4. numbering goes on into the next definition"
  0 steps !  s" :noname step ;  :noname step ;" compile-source  execute 2 assert=  execute 1 assert= ;test
test" 4. a step counts when compiled"  0 steps !  s" :noname step step ; drop" compile-source  steps @ 2 assert= ;test

test" 5. four repeats"  s" :noname 0 4 times 1+ end-times ;" compile-source execute 4 assert= ;test
test" 5. no repeats"  s" :noname 10 0 times 1+ end-times ;" compile-source execute 10 assert= ;test
test" 5. the index counts from 0"  s" :noname 0 5 times i + end-times ;" compile-source execute 10 assert= ;test
test" 5. times inside a word that takes the count"
  s" :noname ( n -- total ) 0 swap times i + end-times ;" compile-source  3 swap execute 3 assert= ;test

end-tests
