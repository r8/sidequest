(import test :as t)
(import ../dnd-character :as sol)

(t/deftest "ability modifier for score 3 is -4"
  (t/assert-equal -4 (sol/modifier 3)))

(t/deftest "ability modifier for score 4 is -3"
  (t/assert-equal -3 (sol/modifier 4)))

(t/deftest "ability modifier for score 5 is -3"
  (t/assert-equal -3 (sol/modifier 5)))

(t/deftest "ability modifier for score 6 is -2"
  (t/assert-equal -2 (sol/modifier 6)))

(t/deftest "ability modifier for score 7 is -2"
  (t/assert-equal -2 (sol/modifier 7)))

(t/deftest "ability modifier for score 8 is -1"
  (t/assert-equal -1 (sol/modifier 8)))

(t/deftest "ability modifier for score 9 is -1"
  (t/assert-equal -1 (sol/modifier 9)))

(t/deftest "ability modifier for score 10 is 0"
  (t/assert-equal 0 (sol/modifier 10)))

(t/deftest "ability modifier for score 11 is 0"
  (t/assert-equal 0 (sol/modifier 11)))

(t/deftest "ability modifier for score 12 is +1"
  (t/assert-equal 1 (sol/modifier 12)))

(t/deftest "ability modifier for score 13 is +1"
  (t/assert-equal 1 (sol/modifier 13)))

(t/deftest "ability modifier for score 14 is +2"
  (t/assert-equal 2 (sol/modifier 14)))

(t/deftest "ability modifier for score 15 is +2"
  (t/assert-equal 2 (sol/modifier 15)))

(t/deftest "ability modifier for score 16 is +3"
  (t/assert-equal 3 (sol/modifier 16)))

(t/deftest "ability modifier for score 17 is +3"
  (t/assert-equal 3 (sol/modifier 17)))

(t/deftest "ability modifier for score 18 is +4"
  (t/assert-equal 4 (sol/modifier 18)))

(def- abilities [:strength :dexterity :constitution :intelligence :wisdom :charisma])

(defn- in-range? [score] (<= 3 score 18))

(t/deftest "random ability is within range"
  (repeat 100
    (t/assert-true (in-range? (sol/ability)))))

(t/deftest "random character is valid"
  (repeat 100
    (def c (sol/character))
    (each a abilities
      (t/assert-true (in-range? (c a)) (string/format "%v out of range in %q" a c)))
    (t/assert-equal (+ 10 (sol/modifier (c :constitution))) (c :hitpoints))))

(t/deftest "each ability is only calculated once"
  (repeat 100
    (def c (sol/character))
    (each a abilities
      (t/assert-equal (c a) (c a)))))

(t/run)
