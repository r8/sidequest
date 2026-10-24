(import test :as t)
(import ../post-office :as sol)

(t/deftest "1. posting returns the mailbox"
  (def box (ev/chan 10))
  (t/assert-true (= box (sol/post box @["for Ada"]))))

(t/deftest "1. the letters are in the mailbox, in order"
  (def box (sol/post (ev/chan 10) @["for Ada" "for Bo"]))
  (t/assert-equal ["for Ada" "for Bo"] [(ev/take box) (ev/take box)]))

(t/deftest "1. posting nothing"
  (t/assert-equal 0 (ev/count (sol/post (ev/chan 10) @[]))))

(t/deftest "2. collecting some letters"
  (def box (sol/post (ev/chan 10) @["for Ada" "for Bo" "for Cy"]))
  (t/assert-equal ["for Ada" "for Bo"] (sol/collect box 2)))

(t/deftest "2. the rest stay in the mailbox"
  (def box (sol/post (ev/chan 10) @["for Ada" "for Bo" "for Cy"]))
  (sol/collect box 2)
  (t/assert-equal 1 (ev/count box)))

(t/deftest "2. collecting nothing"
  (t/assert-equal [] (sol/collect (ev/chan 1) 0)))

(t/deftest "2. collecting waits for letters still on their way"
  (def box (ev/chan))
  (ev/go (fn [] (ev/sleep 0.01) (ev/give box "late letter")))
  (t/assert-equal ["late letter"] (sol/collect box 1)))

(t/deftest "3. the stamper is a task"
  (def in (ev/chan))
  (def task (sol/start-stamper in (ev/chan 1)))
  (t/assert-true (fiber? task))
  (ev/chan-close in))

(t/deftest "3. one stamped letter"
  (def in (ev/chan))
  (def out (ev/chan 10))
  (sol/start-stamper in out)
  (ev/give in "for Ada")
  (t/assert-equal "for Ada [stamped]" (ev/take out))
  (ev/chan-close in))

(t/deftest "3. letters are stamped in order"
  (def in (ev/chan 10))
  (def out (ev/chan 10))
  (sol/start-stamper in out)
  (sol/post in @["one" "two" "three"])
  (t/assert-equal ["one [stamped]" "two [stamped]" "three [stamped]"] (sol/collect out 3))
  (ev/chan-close in))

(t/deftest "3. the stamper finishes when its input is closed"
  (def in (ev/chan))
  (def task (sol/start-stamper in (ev/chan 1)))
  (ev/sleep 0)
  (ev/chan-close in)
  (ev/sleep 0)
  (t/assert-equal :dead (fiber/status task)))

(t/deftest "4. running the office on two letters"
  (t/assert-equal ["for Ada [stamped]" "for Bo [stamped]"] (sol/run-office @["for Ada" "for Bo"])))

(t/deftest "4. running the office on many letters"
  (def letters (map |(string "letter " $) (range 50)))
  (t/assert-equal (map |(string $ " [stamped]") letters) (sol/run-office letters)))

(t/deftest "4. a quiet day"
  (t/assert-equal [] (sol/run-office @[])))

(t/deftest "5. both results, the first courier's first"
  (t/assert-equal [:island :village] (sol/deliver-both (fn [] (ev/sleep 0.01) :island) (fn [] :village))))

(t/deftest "5. the couriers travel at the same time"
  (def log @[])
  (sol/deliver-both
    (fn [] (array/push log :ferry-leaves) (ev/sleep 0.05) (array/push log :ferry-arrives))
    (fn [] (array/push log :bicycle-leaves) (ev/sleep 0.01) (array/push log :bicycle-arrives)))
  (t/assert-equal [:ferry-leaves :bicycle-leaves :bicycle-arrives :ferry-arrives] log))

(t/run)
