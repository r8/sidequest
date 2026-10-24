(import test :as t)
(import ../conveyor-belt :as sol)

(t/deftest "1. the belt is a fiber"
  (t/assert-true (fiber? (sol/make-belt @["truffles"]))))

(t/deftest "1. the first box comes first"
  (def belt (sol/make-belt @["truffles" "pralines"]))
  (t/assert-equal "truffles" (resume belt)))

(t/deftest "1. the boxes come one at a time, in order"
  (def belt (sol/make-belt @["truffles" "pralines" "nougat"]))
  (t/assert-equal ["truffles" "pralines" "nougat"] [(resume belt) (resume belt) (resume belt)]))

(t/deftest "1. loading the belt takes nothing off it"
  (t/assert-equal :new (fiber/status (sol/make-belt @["truffles"]))))

(t/deftest "2. the next box"
  (def belt (sol/make-belt @["truffles" "pralines"]))
  (t/assert-equal ["truffles" "pralines"] [(sol/next-box belt) (sol/next-box belt)]))

(t/deftest "2. an empty belt gives nil"
  (def belt (sol/make-belt @["truffles"]))
  (sol/next-box belt)
  (t/assert-equal nil (sol/next-box belt)))

(t/deftest "2. an empty belt keeps giving nil"
  (def belt (sol/make-belt @[]))
  (t/assert-equal [nil nil nil] [(sol/next-box belt) (sol/next-box belt) (sol/next-box belt)]))

(t/deftest "3. unloading a full belt"
  (t/assert-equal ["truffles" "pralines" "nougat"] (sol/unload (sol/make-belt @["truffles" "pralines" "nougat"]))))

(t/deftest "3. unloading what is left"
  (def belt (sol/make-belt @["truffles" "pralines" "nougat"]))
  (sol/next-box belt)
  (t/assert-equal ["pralines" "nougat"] (sol/unload belt)))

(t/deftest "3. unloading an empty belt"
  (t/assert-equal [] (sol/unload (sol/make-belt @[]))))

(t/deftest "3. nothing is left after unloading"
  (def belt (sol/make-belt @["truffles" "pralines"]))
  (sol/unload belt)
  (t/assert-equal nil (sol/next-box belt)))

(t/deftest "4. the first label"
  (t/assert-equal "XMAS-1" (resume (sol/labels "XMAS"))))

(t/deftest "4. labels count up"
  (def printer (sol/labels "BOX"))
  (t/assert-equal ["BOX-1" "BOX-2" "BOX-3"] [(resume printer) (resume printer) (resume printer)]))

(t/deftest "4. the labels never run out"
  (def printer (sol/labels "A"))
  (for i 0 99 (resume printer))
  (t/assert-equal "A-100" (resume printer)))

(t/deftest "4. each printer counts on its own"
  (def first-printer (sol/labels "A"))
  (def second-printer (sol/labels "B"))
  (resume first-printer)
  (t/assert-equal "B-1" (resume second-printer)))

(t/deftest "5. weighing one box"
  (t/assert-equal 250 (resume (sol/make-scale) 250)))

(t/deftest "5. a running total"
  (def scale (sol/make-scale))
  (t/assert-equal [250 750 800] [(resume scale 250) (resume scale 500) (resume scale 50)]))

(t/deftest "5. each scale weighs on its own"
  (def a (sol/make-scale))
  (def b (sol/make-scale))
  (resume a 100)
  (t/assert-equal 7 (resume b 7)))

(t/run)
