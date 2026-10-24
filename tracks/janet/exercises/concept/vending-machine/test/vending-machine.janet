(import test :as t)
(import ../vending-machine :as sol)

(defn new-machine []
  @{"A1" @{:name "Crisps" :price 120 :stock 3}
    "A2" @{:name "Pretzels" :price 100 :stock 1}
    "B2" @{:name "Apple" :price 80 :stock 0}})

(t/deftest "1. dispense a snack"
  (t/assert-equal "Crisps" (sol/dispense (new-machine) "A1")))

(t/deftest "1. dispensing lowers the stock"
  (def machine (new-machine))
  (sol/dispense machine "A1")
  (sol/dispense machine "A1")
  (t/assert-equal 1 (get-in machine ["A1" :stock])))

(t/deftest "1. a slot that does not exist"
  (t/assert-error "no such slot: C7" (sol/dispense (new-machine) "C7")))

(t/deftest "1. a sold-out slot"
  (t/assert-error "sold out: Apple" (sol/dispense (new-machine) "B2")))

(t/deftest "1. the last item, then sold out"
  (def machine (new-machine))
  (sol/dispense machine "A2")
  (t/assert-error "sold out: Pretzels" (sol/dispense machine "A2")))

(t/deftest "2. dispense a snack without complaining"
  (t/assert-equal "Pretzels" (sol/try-dispense (new-machine) "A2")))

(t/deftest "2. nothing for a slot that does not exist"
  (t/assert-equal nil (sol/try-dispense (new-machine) "C7")))

(t/deftest "2. nothing for a sold-out slot"
  (t/assert-equal nil (sol/try-dispense (new-machine) "B2")))

(t/deftest "3. the total of good coins"
  (t/assert-equal 120 (sol/insert-coins [100 20])))

(t/deftest "3. every kind of coin"
  (t/assert-equal 380 (sol/insert-coins [10 20 50 100 200])))

(t/deftest "3. no coins"
  (t/assert-equal 0 (sol/insert-coins [])))

(t/deftest "3. a coin the machine does not take"
  (t/assert-error "unknown coin" (sol/insert-coins [100 25])))

(t/deftest "3. a bad coin first"
  (t/assert-error "unknown coin" (sol/insert-coins [5 100 100])))

(t/deftest "4. a snack when there is one"
  (t/assert-equal "Crisps" (sol/restock-check (new-machine) "A1")))

(t/deftest "4. empty for a sold-out slot"
  (t/assert-equal :empty (sol/restock-check (new-machine) "B2")))

(t/deftest "4. other errors are raised again"
  (t/assert-error "no such slot: C7" (sol/restock-check (new-machine) "C7")))

(t/deftest "5. a successful attempt"
  (t/assert-equal [:ok "Crisps"] (sol/attempt (fn [] (sol/dispense (new-machine) "A1")))))

(t/deftest "5. a failed attempt"
  (t/assert-equal [:error "no such slot: C7"] (sol/attempt (fn [] (sol/dispense (new-machine) "C7")))))

(t/deftest "5. an error value that is not a string"
  (t/assert-equal [:error :jammed] (sol/attempt (fn [] (error :jammed)))))

(t/deftest "5. a result that is nil"
  (t/assert-equal [:ok nil] (sol/attempt (fn [] nil))))

(t/run)
