require ../lib/test.fs
require ../measuring-cups.fs

\ Defining words read the new word's name from the source, so each test defines its words with
\ evaluate as it runs, and uses them through evaluate too: a word that a test defines does not
\ exist yet when the test is compiled. (Several tests define the same names; later ones replace
\ earlier ones.)

test" 1. two cups"  s" 250 unit cups  2 cups" evaluate 500 assert= ;test
test" 1. one teaspoon"  s" 5 unit teaspoons  1 teaspoons" evaluate 5 assert= ;test
test" 1. no tablespoons"  s" 15 unit tablespoons  0 tablespoons" evaluate 0 assert= ;test
test" 1. two units used together"
  s" 250 unit cups  15 unit tablespoons  2 cups 3 tablespoons +" evaluate 545 assert= ;test

test" 2. the first stir"  s" counter stirs  stirs" evaluate 1 assert= ;test
test" 2. three stirs"  s" counter stirs  stirs stirs stirs" evaluate 3 assert= 2 assert= 1 assert= ;test
test" 2. two counters count separately"
  s" counter stirs  counter folds  stirs stirs folds stirs" evaluate 3 assert= 1 assert= 2 assert= 1 assert= ;test

test" 3. a reset counter starts again"
  s" counter stirs  stirs drop stirs drop  ' stirs reset-counter  stirs" evaluate 1 assert= ;test
test" 3. resetting one counter leaves the other"
  s" counter stirs  counter folds  stirs drop folds drop folds drop  ' stirs reset-counter  stirs folds" evaluate
  3 assert= 1 assert= ;test

test" 4. a jar keeps what is put in it"  s" 4 shelf spices  30 2 spices !  2 spices @" evaluate 30 assert= ;test
\ Fresh dictionary space is often zero already; scribbling over it first makes sure shelf clears it.
test" 4. jars start empty"
  here 64 cells 255 fill  s" 4 shelf spices  0 spices @  3 spices @" evaluate 0 assert= 0 assert= ;test
test" 4. jars are separate cells"
  s" 3 shelf spices  10 0 spices !  20 1 spices !  30 2 spices !  0 spices @ 1 spices @ 2 spices @" evaluate
  30 assert= 20 assert= 10 assert= ;test
test" 4. jars are one cell apart"  s" 5 shelf spices  1 spices  0 spices -" evaluate 1 cells assert= ;test

end-tests
