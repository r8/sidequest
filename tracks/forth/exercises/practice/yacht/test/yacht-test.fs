require ../lib/test.fs
require ../yacht.fs

test" Yacht"  5 5 5 5 5 yacht score 50 assert= ;test
test" Not Yacht"  1 3 3 2 5 yacht score 0 assert= ;test
test" Ones"  1 1 1 3 5 ones score 3 assert= ;test
test" Ones, out of order"  3 1 1 5 1 ones score 3 assert= ;test
test" No ones"  4 3 6 5 5 ones score 0 assert= ;test
test" Twos"  2 3 4 5 6 twos score 2 assert= ;test
test" Fours"  1 4 1 4 1 fours score 8 assert= ;test
test" Yacht counted as threes"  3 3 3 3 3 threes score 15 assert= ;test
test" Yacht of 3s counted as fives"  3 3 3 3 3 fives score 0 assert= ;test
test" Fives"  1 5 3 5 3 fives score 10 assert= ;test
test" Sixes"  2 3 4 5 6 sixes score 6 assert= ;test
test" Full house two small, three big"  2 2 4 4 4 full-house score 16 assert= ;test
test" Full house three small, two big"  5 3 3 5 3 full-house score 19 assert= ;test
test" Two pair is not a full house"  2 2 4 4 5 full-house score 0 assert= ;test
test" Four of a kind is not a full house"  1 4 4 4 4 full-house score 0 assert= ;test
test" Yacht is not a full house"  2 2 2 2 2 full-house score 0 assert= ;test
test" Four of a Kind"  6 6 4 6 6 four-of-a-kind score 24 assert= ;test
test" Yacht can be scored as Four of a Kind"  3 3 3 3 3 four-of-a-kind score 12 assert= ;test
test" Full house is not Four of a Kind"  3 3 3 5 5 four-of-a-kind score 0 assert= ;test
test" Little Straight"  3 5 4 1 2 little-straight score 30 assert= ;test
test" Little Straight as Big Straight"  1 2 3 4 5 big-straight score 0 assert= ;test
test" Four in order but not a little straight"  1 1 2 3 4 little-straight score 0 assert= ;test
test" No pairs but not a little straight"  1 2 3 4 6 little-straight score 0 assert= ;test
test" Minimum is 1, maximum is 5, but not a little straight"  1 1 3 4 5 little-straight score 0 assert= ;test
test" Big Straight"  4 6 2 5 3 big-straight score 30 assert= ;test
test" Big Straight as little straight"  6 5 4 3 2 little-straight score 0 assert= ;test
test" No pairs but not a big straight"  6 5 4 3 1 big-straight score 0 assert= ;test
test" Choice"  3 3 5 6 6 choice score 23 assert= ;test
test" Yacht as choice"  2 2 2 2 2 choice score 10 assert= ;test

end-tests
