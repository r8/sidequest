(import test :as t)
(import ../reverse-string :as sol)

(t/deftest "an empty string"
  (t/assert-equal "" (sol/reverse "")))

(t/deftest "a word"
  (t/assert-equal "tobor" (sol/reverse "robot")))

(t/deftest "a capitalized word"
  (t/assert-equal "nemaR" (sol/reverse "Ramen")))

(t/deftest "a sentence with punctuation"
  (t/assert-equal "!yrgnuh m'I" (sol/reverse "I'm hungry!")))

(t/deftest "a palindrome"
  (t/assert-equal "racecar" (sol/reverse "racecar")))

(t/deftest "an even-sized word"
  (t/assert-equal "reward" (sol/reverse "drawer")))

(t/run)
