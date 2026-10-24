require ../lib/test.fs
require ../isogram.fs

test" empty string"  s" " isogram? assert-true ;test
test" isogram with only lower case characters"  s" isogram" isogram? assert-true ;test
test" word with one duplicated character"  s" eleven" isogram? assert-false ;test
test" word with one duplicated character from the end of the alphabet"  s" zzyzx" isogram? assert-false ;test
test" longest reported english isogram"  s" subdermatoglyphic" isogram? assert-true ;test
test" word with duplicated character in mixed case"  s" Alphabet" isogram? assert-false ;test
test" word with duplicated character in mixed case, lowercase first"  s" alphAbet" isogram? assert-false ;test
test" hypothetical isogrammic word with hyphen"  s" thumbscrew-japingly" isogram? assert-true ;test
test" hypothetical word with duplicated character following hyphen"  s" thumbscrew-jappingly" isogram? assert-false ;test
test" isogram with duplicated hyphen"  s" six-year-old" isogram? assert-true ;test
test" made-up name that is an isogram"  s" Emily Jung Schwartzkopf" isogram? assert-true ;test
test" duplicated character in the middle"  s" accentor" isogram? assert-false ;test
test" same first and last characters"  s" angola" isogram? assert-false ;test
test" word with duplicated character and with two hyphens"  s" up-to-date" isogram? assert-false ;test

end-tests
