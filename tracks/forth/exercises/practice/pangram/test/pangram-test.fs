require ../lib/test.fs
require ../pangram.fs

test" empty sentence"  s" " pangram? assert-false ;test
test" perfect lower case"  s" abcdefghijklmnopqrstuvwxyz" pangram? assert-true ;test
test" only lower case"  s" the quick brown fox jumps over the lazy dog" pangram? assert-true ;test
test" missing the letter 'x'"  s" a quick movement of the enemy will jeopardize five gunboats" pangram? assert-false ;test
test" missing the letter 'h'"  s" five boxing wizards jump quickly at it" pangram? assert-false ;test
test" with underscores"  s" the_quick_brown_fox_jumps_over_the_lazy_dog" pangram? assert-true ;test
test" with numbers"  s" the 1 quick brown fox jumps over the 2 lazy dogs" pangram? assert-true ;test
test" missing letters replaced by numbers"  s" 7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog" pangram? assert-false ;test
test" mixed case and punctuation"  s\" \"Five quacking Zephyrs jolt my wax bed.\"" pangram? assert-true ;test
test" a-m and A-M are 26 different characters but not a pangram"  s" abcdefghijklm ABCDEFGHIJKLM" pangram? assert-false ;test

end-tests
