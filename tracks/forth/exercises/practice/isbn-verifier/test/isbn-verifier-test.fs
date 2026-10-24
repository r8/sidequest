require ../lib/test.fs
require ../isbn-verifier.fs

test" valid isbn"  s" 3-598-21508-8" valid-isbn? assert-true ;test
test" invalid isbn check digit"  s" 3-598-21508-9" valid-isbn? assert-false ;test
test" valid isbn with a check digit of 10"  s" 3-598-21507-X" valid-isbn? assert-true ;test
test" check digit is a character other than X"  s" 3-598-21507-A" valid-isbn? assert-false ;test
test" invalid check digit in isbn is not treated as zero"  s" 4-598-21507-B" valid-isbn? assert-false ;test
test" invalid character in isbn is not treated as zero"  s" 3-598-P1581-X" valid-isbn? assert-false ;test
test" X is only valid as a check digit"  s" 3-598-2X507-9" valid-isbn? assert-false ;test
test" only one check digit is allowed"  s" 3-598-21508-96" valid-isbn? assert-false ;test
test" X is not substituted by the value 10"  s" 3-598-2X507-5" valid-isbn? assert-false ;test
test" valid isbn without separating dashes"  s" 3598215088" valid-isbn? assert-true ;test
test" isbn without separating dashes and X as check digit"  s" 359821507X" valid-isbn? assert-true ;test
test" isbn without check digit and dashes"  s" 359821507" valid-isbn? assert-false ;test
test" too long isbn and no dashes"  s" 3598215078X" valid-isbn? assert-false ;test
test" too short isbn"  s" 00" valid-isbn? assert-false ;test
test" isbn without check digit"  s" 3-598-21507" valid-isbn? assert-false ;test
test" check digit of X should not be used for 0"  s" 3-598-21515-X" valid-isbn? assert-false ;test
test" empty isbn"  s" " valid-isbn? assert-false ;test
test" input is 9 characters"  s" 134456729" valid-isbn? assert-false ;test
test" invalid characters are not ignored after checking length"  s" 3132P34035" valid-isbn? assert-false ;test
test" invalid characters are not ignored before checking length"  s" 3598P215088" valid-isbn? assert-false ;test
test" input is too long but contains a valid isbn"  s" 98245726788" valid-isbn? assert-false ;test

end-tests
