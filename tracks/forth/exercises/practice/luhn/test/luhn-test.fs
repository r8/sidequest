require ../lib/test.fs
require ../luhn.fs

test" single digit strings can not be valid"  s" 1" valid? assert-false ;test
test" a single zero is invalid"  s" 0" valid? assert-false ;test
test" a simple valid SIN that remains valid if reversed"  s" 059" valid? assert-true ;test
test" a simple valid SIN that becomes invalid if reversed"  s" 59" valid? assert-true ;test
test" a valid Canadian SIN"  s" 055 444 285" valid? assert-true ;test
test" invalid Canadian SIN"  s" 055 444 286" valid? assert-false ;test
test" invalid credit card"  s" 8273 1232 7352 0569" valid? assert-false ;test
test" invalid long number with an even remainder"  s" 1 2345 6789 1234 5678 9012" valid? assert-false ;test
test" invalid long number with a remainder divisible by 5"  s" 1 2345 6789 1234 5678 9013" valid? assert-false ;test
test" valid number with an even number of digits"  s" 095 245 88" valid? assert-true ;test
test" valid number with an odd number of spaces"  s" 234 567 891 234" valid? assert-true ;test
test" valid strings with a non-digit added at the end become invalid"  s" 059a" valid? assert-false ;test
test" valid strings with punctuation included become invalid"  s" 055-444-285" valid? assert-false ;test
test" valid strings with symbols included become invalid"  s" 055# 444$ 285" valid? assert-false ;test
test" single zero with space is invalid"  s"  0" valid? assert-false ;test
test" more than a single zero is valid"  s" 0000 0" valid? assert-true ;test
test" input digit 9 is correctly converted to output digit 9"  s" 091" valid? assert-true ;test
test" very long input is valid"  s" 9999999999 9999999999 9999999999 9999999999" valid? assert-true ;test
test" valid luhn with an odd number of digits and non zero first digit"  s" 109" valid? assert-true ;test
test" using ascii value for non-doubled non-digit isn't allowed"  s" 055b 444 285" valid? assert-false ;test
test" using ascii value for doubled non-digit isn't allowed"  s" :9" valid? assert-false ;test
test" non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"  s" 59%59" valid? assert-false ;test

end-tests
