require ../lib/test.fs
require ../armstrong-numbers.fs

test" Zero is an Armstrong number"  0 armstrong? assert-true ;test
test" Single-digit numbers are Armstrong numbers"  5 armstrong? assert-true ;test
test" There are no two-digit Armstrong numbers"  10 armstrong? assert-false ;test
test" Three-digit number that is an Armstrong number"  153 armstrong? assert-true ;test
test" Three-digit number that is not an Armstrong number"  100 armstrong? assert-false ;test
test" Four-digit number that is an Armstrong number"  9474 armstrong? assert-true ;test
test" Four-digit number that is not an Armstrong number"  9475 armstrong? assert-false ;test
test" Seven-digit number that is an Armstrong number"  9926315 armstrong? assert-true ;test
test" Seven-digit number that is not an Armstrong number"  9926314 armstrong? assert-false ;test

end-tests
