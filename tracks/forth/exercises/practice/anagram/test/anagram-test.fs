require ../lib/test.fs
require ../anagram.fs

test" no matches"  s" diaper" s" hello world zombies pants" find-anagrams  s" " assert-str= ;test
test" detects two anagrams"  s" solemn" s" lemons cherry melons" find-anagrams  s" lemons melons" assert-str= ;test
test" does not detect anagram subsets"  s" good" s" dog goody" find-anagrams  s" " assert-str= ;test
test" detects anagram"  s" listen" s" enlists google inlets banana" find-anagrams  s" inlets" assert-str= ;test
test" detects three anagrams"
  s" allergy" s" gallery ballerina regally clergy largely leading" find-anagrams
  s" gallery regally largely" assert-str= ;test
test" detects multiple anagrams with different case"  s" nose" s" Eons ONES" find-anagrams  s" Eons ONES" assert-str= ;test
test" does not detect non-anagrams with identical checksum"  s" mass" s" last" find-anagrams  s" " assert-str= ;test
test" detects anagrams case-insensitively"
  s" Orchestra" s" cashregister Carthorse radishes" find-anagrams  s" Carthorse" assert-str= ;test
test" detects anagrams using case-insensitive subject"
  s" Orchestra" s" cashregister carthorse radishes" find-anagrams  s" carthorse" assert-str= ;test
test" detects anagrams using case-insensitive possible matches"
  s" orchestra" s" cashregister Carthorse radishes" find-anagrams  s" Carthorse" assert-str= ;test
test" does not detect an anagram if the original word is repeated"  s" go" s" goGoGO" find-anagrams  s" " assert-str= ;test
test" anagrams must use all letters exactly once"  s" tapper" s" patter" find-anagrams  s" " assert-str= ;test
test" words are not anagrams of themselves"  s" BANANA" s" BANANA" find-anagrams  s" " assert-str= ;test
test" words are not anagrams of themselves even if letter case is partially different"
  s" BANANA" s" Banana" find-anagrams  s" " assert-str= ;test
test" words are not anagrams of themselves even if letter case is completely different"
  s" BANANA" s" banana" find-anagrams  s" " assert-str= ;test
test" words other than themselves can be anagrams"  s" LISTEN" s" LISTEN Silent" find-anagrams  s" Silent" assert-str= ;test

\ Not in the canonical data: more matches than fit in a counted string, or in any fixed-size buffer
\ a solution might reach for.
create many-candidates 399 chars allot  many-candidates 399 bl fill
: fill-candidates ( -- ) 399 0 do  s" tab" many-candidates i chars + swap chars move  4 +loop ;
fill-candidates
test" many anagrams"  s" bat" many-candidates 399 find-anagrams many-candidates 399 assert-str= ;test

end-tests
