require ../lib/test.fs
require ../scrabble-score.fs

test" lowercase letter"  s" a" score 1 assert= ;test
test" uppercase letter"  s" A" score 1 assert= ;test
test" valuable letter"  s" f" score 4 assert= ;test
test" short word"  s" at" score 2 assert= ;test
test" short, valuable word"  s" zoo" score 12 assert= ;test
test" medium word"  s" street" score 6 assert= ;test
test" medium, valuable word"  s" quirky" score 22 assert= ;test
test" long, mixed-case word"  s" OxyphenButazone" score 41 assert= ;test
test" english-like word"  s" pinata" score 8 assert= ;test
test" empty input"  s" " score 0 assert= ;test
test" entire alphabet available"  s" abcdefghijklmnopqrstuvwxyz" score 87 assert= ;test

end-tests
