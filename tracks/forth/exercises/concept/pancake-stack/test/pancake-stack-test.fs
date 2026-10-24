require ../lib/test.fs
require ../pancake-stack.fs

test" 1. pancakes for four guests"  4 pancakes-for 12 assert= ;test
test" 1. pancakes for one guest are the smallest batch"  1 pancakes-for 6 assert= ;test
test" 1. pancakes for two guests"  2 pancakes-for 6 assert= ;test
test" 1. pancakes for ten guests"  10 pancakes-for 30 assert= ;test

test" 2. height of a stack of three"  3 stack-height 29 assert= ;test
test" 2. height of a single pancake"  1 stack-height 13 assert= ;test
test" 2. height of a stack of twelve"  12 stack-height 101 assert= ;test

test" 3. ten pancakes fill two plates"  10 full-plates 2 assert= ;test
test" 3. three pancakes fill no plate"  3 full-plates 0 assert= ;test
test" 3. sixteen pancakes fill four plates"  16 full-plates 4 assert= ;test

test" 4. ten pancakes leave two spare"  10 spare-pancakes 2 assert= ;test
test" 4. sixteen pancakes leave none spare"  16 spare-pancakes 0 assert= ;test
test" 4. three pancakes are all spare"  3 spare-pancakes 3 assert= ;test

test" 5. twelve pancakes take two rounds"  12 griddle-rounds 2 assert= ;test
test" 5. thirteen pancakes take three rounds"  13 griddle-rounds 3 assert= ;test
test" 5. one pancake takes a round"  1 griddle-rounds 1 assert= ;test
test" 5. no pancakes take no rounds"  0 griddle-rounds 0 assert= ;test

end-tests
