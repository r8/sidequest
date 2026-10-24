(import test :as t)
(import ../pangram :as sol)

(t/deftest "empty sentence"
  (t/assert-false (sol/pangram? "")))

(t/deftest "perfect lower case"
  (t/assert-true (sol/pangram? "abcdefghijklmnopqrstuvwxyz")))

(t/deftest "only lower case"
  (t/assert-true (sol/pangram? "the quick brown fox jumps over the lazy dog")))

(t/deftest "missing the letter 'x'"
  (t/assert-false (sol/pangram? "a quick movement of the enemy will jeopardize five gunboats")))

(t/deftest "missing the letter 'h'"
  (t/assert-false (sol/pangram? "five boxing wizards jump quickly at it")))

(t/deftest "with underscores"
  (t/assert-true (sol/pangram? "the_quick_brown_fox_jumps_over_the_lazy_dog")))

(t/deftest "with numbers"
  (t/assert-true (sol/pangram? "the 1 quick brown fox jumps over the 2 lazy dogs")))

(t/deftest "missing letters replaced by numbers"
  (t/assert-false (sol/pangram? "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")))

(t/deftest "mixed case and punctuation"
  (t/assert-true (sol/pangram? "\"Five quacking Zephyrs jolt my wax bed.\"")))

(t/deftest "a-m and A-M are 26 different characters but not a pangram"
  (t/assert-false (sol/pangram? "abcdefghijklm ABCDEFGHIJKLM")))

(t/run)
