(import test :as t)
(import ../rotational-cipher :as sol)

(t/deftest "rotate a by 0, same output as input"
  (t/assert-equal "a" (sol/rotate "a" 0)))

(t/deftest "rotate a by 1"
  (t/assert-equal "b" (sol/rotate "a" 1)))

(t/deftest "rotate a by 26, same output as input"
  (t/assert-equal "a" (sol/rotate "a" 26)))

(t/deftest "rotate m by 13"
  (t/assert-equal "z" (sol/rotate "m" 13)))

(t/deftest "rotate n by 13 with wrap around alphabet"
  (t/assert-equal "a" (sol/rotate "n" 13)))

(t/deftest "rotate capital letters"
  (t/assert-equal "TRL" (sol/rotate "OMG" 5)))

(t/deftest "rotate spaces"
  (t/assert-equal "T R L" (sol/rotate "O M G" 5)))

(t/deftest "rotate numbers"
  (t/assert-equal "Xiwxmrk 1 2 3 xiwxmrk" (sol/rotate "Testing 1 2 3 testing" 4)))

(t/deftest "rotate punctuation"
  (t/assert-equal "Gzo'n zvo, Bmviyhv!" (sol/rotate "Let's eat, Grandma!" 21)))

(t/deftest "rotate all letters"
  (t/assert-equal "Gur dhvpx oebja sbk whzcf bire gur ynml qbt." (sol/rotate "The quick brown fox jumps over the lazy dog." 13)))

(t/run)
