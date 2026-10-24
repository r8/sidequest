(import test :as t)
(import ../raindrops :as sol)

(t/deftest "the sound for 1 is 1"
  (t/assert-equal "1" (sol/convert 1)))

(t/deftest "the sound for 3 is Pling"
  (t/assert-equal "Pling" (sol/convert 3)))

(t/deftest "the sound for 5 is Plang"
  (t/assert-equal "Plang" (sol/convert 5)))

(t/deftest "the sound for 7 is Plong"
  (t/assert-equal "Plong" (sol/convert 7)))

(t/deftest "the sound for 6 is Pling as it has a factor 3"
  (t/assert-equal "Pling" (sol/convert 6)))

(t/deftest "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base"
  (t/assert-equal "8" (sol/convert 8)))

(t/deftest "the sound for 9 is Pling as it has a factor 3"
  (t/assert-equal "Pling" (sol/convert 9)))

(t/deftest "the sound for 10 is Plang as it has a factor 5"
  (t/assert-equal "Plang" (sol/convert 10)))

(t/deftest "the sound for 14 is Plong as it has a factor of 7"
  (t/assert-equal "Plong" (sol/convert 14)))

(t/deftest "the sound for 15 is PlingPlang as it has factors 3 and 5"
  (t/assert-equal "PlingPlang" (sol/convert 15)))

(t/deftest "the sound for 21 is PlingPlong as it has factors 3 and 7"
  (t/assert-equal "PlingPlong" (sol/convert 21)))

(t/deftest "the sound for 25 is Plang as it has a factor 5"
  (t/assert-equal "Plang" (sol/convert 25)))

(t/deftest "the sound for 27 is Pling as it has a factor 3"
  (t/assert-equal "Pling" (sol/convert 27)))

(t/deftest "the sound for 35 is PlangPlong as it has factors 5 and 7"
  (t/assert-equal "PlangPlong" (sol/convert 35)))

(t/deftest "the sound for 49 is Plong as it has a factor 7"
  (t/assert-equal "Plong" (sol/convert 49)))

(t/deftest "the sound for 52 is 52"
  (t/assert-equal "52" (sol/convert 52)))

(t/deftest "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7"
  (t/assert-equal "PlingPlangPlong" (sol/convert 105)))

(t/deftest "the sound for 3125 is Plang as it has a factor 5"
  (t/assert-equal "Plang" (sol/convert 3125)))

(t/run)
