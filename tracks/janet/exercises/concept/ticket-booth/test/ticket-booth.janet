(import test :as t)
(import ../ticket-booth :as sol)

(t/deftest "1. the first ticket has the first number"
  (def next-ticket (sol/make-dispenser 100))
  (t/assert-equal 100 (next-ticket)))

(t/deftest "1. tickets are numbered in order"
  (def next-ticket (sol/make-dispenser 100))
  (t/assert-equal [100 101 102] [(next-ticket) (next-ticket) (next-ticket)]))

(t/deftest "1. two dispensers count separately"
  (def stalls (sol/make-dispenser 1))
  (def balcony (sol/make-dispenser 500))
  (stalls)
  (stalls)
  (t/assert-equal [500 3 501] [(balcony) (stalls) (balcony)]))

(t/deftest "2. a 20 percent discount"
  (def student (sol/make-discount 20))
  (t/assert-equal 20 (student 25)))

(t/deftest "2. a half-price discount"
  (def half (sol/make-discount 50))
  (t/assert-equal [15 6] [(half 30) (half 12)]))

(t/deftest "2. no discount"
  (def full (sol/make-discount 0))
  (t/assert-equal 18 (full 18)))

(t/deftest "3. tickets while they last"
  (def matinee (sol/make-limited-dispenser 1 2))
  (t/assert-equal [1 2] [(matinee) (matinee)]))

(t/deftest "3. nil once sold out"
  (def matinee (sol/make-limited-dispenser 1 2))
  (t/assert-equal [1 2 nil nil] [(matinee) (matinee) (matinee) (matinee)]))

(t/deftest "3. a show with no tickets"
  (def private-show (sol/make-limited-dispenser 1 0))
  (t/assert-equal nil (private-show)))

(t/deftest "3. two shows sell out separately"
  (def early (sol/make-limited-dispenser 10 1))
  (def late (sol/make-limited-dispenser 20 2))
  (t/assert-equal [10 nil 20 21 nil] [(early) (early) (late) (late) (late)]))

(t/deftest "4. a new tally has sold nothing"
  (def tally (sol/make-tally))
  (t/assert-equal 0 ((tally :sold))))

(t/deftest "4. selling returns the new count"
  (def tally (sol/make-tally))
  (t/assert-equal [3 5] [((tally :sell) 3) ((tally :sell) 2)]))

(t/deftest "4. sold reports what was sold"
  (def tally (sol/make-tally))
  ((tally :sell) 3)
  ((tally :sell) 4)
  (t/assert-equal 7 ((tally :sold))))

(t/deftest "4. two tallies are independent"
  (def friday (sol/make-tally))
  (def saturday (sol/make-tally))
  ((friday :sell) 10)
  ((saturday :sell) 2)
  (t/assert-equal [10 2] [((friday :sold)) ((saturday :sold))]))

(t/run)
