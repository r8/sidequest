(import test :as t)
(import ../anagram :as sol)

(t/deftest "no matches"
  (t/assert-equal [] (sol/find-anagrams "diaper" ["hello" "world" "zombies" "pants"])))

(t/deftest "detects two anagrams"
  (t/assert-equal ["lemons" "melons"] (sol/find-anagrams "solemn" ["lemons" "cherry" "melons"])))

(t/deftest "does not detect anagram subsets"
  (t/assert-equal [] (sol/find-anagrams "good" ["dog" "goody"])))

(t/deftest "detects anagram"
  (t/assert-equal ["inlets"] (sol/find-anagrams "listen" ["enlists" "google" "inlets" "banana"])))

(t/deftest "detects three anagrams"
  (t/assert-equal ["gallery" "regally" "largely"] (sol/find-anagrams "allergy" ["gallery" "ballerina" "regally" "clergy" "largely" "leading"])))

(t/deftest "detects multiple anagrams with different case"
  (t/assert-equal ["Eons" "ONES"] (sol/find-anagrams "nose" ["Eons" "ONES"])))

(t/deftest "does not detect non-anagrams with identical checksum"
  (t/assert-equal [] (sol/find-anagrams "mass" ["last"])))

(t/deftest "detects anagrams case-insensitively"
  (t/assert-equal ["Carthorse"] (sol/find-anagrams "Orchestra" ["cashregister" "Carthorse" "radishes"])))

(t/deftest "detects anagrams using case-insensitive subject"
  (t/assert-equal ["carthorse"] (sol/find-anagrams "Orchestra" ["cashregister" "carthorse" "radishes"])))

(t/deftest "detects anagrams using case-insensitive possible matches"
  (t/assert-equal ["Carthorse"] (sol/find-anagrams "orchestra" ["cashregister" "Carthorse" "radishes"])))

(t/deftest "does not detect an anagram if the original word is repeated"
  (t/assert-equal [] (sol/find-anagrams "go" ["goGoGO"])))

(t/deftest "anagrams must use all letters exactly once"
  (t/assert-equal [] (sol/find-anagrams "tapper" ["patter"])))

(t/deftest "words are not anagrams of themselves"
  (t/assert-equal [] (sol/find-anagrams "BANANA" ["BANANA"])))

(t/deftest "words are not anagrams of themselves even if letter case is partially different"
  (t/assert-equal [] (sol/find-anagrams "BANANA" ["Banana"])))

(t/deftest "words are not anagrams of themselves even if letter case is completely different"
  (t/assert-equal [] (sol/find-anagrams "BANANA" ["banana"])))

(t/deftest "words other than themselves can be anagrams"
  (t/assert-equal ["Silent"] (sol/find-anagrams "LISTEN" ["LISTEN" "Silent"])))

(t/run)
