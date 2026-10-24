(defn dispense
  "(dispense machine code) -> string; the item's name, after taking one from the slot's stock"
  [machine code]
  (def slot (get machine code))
  (unless slot
    (errorf "no such slot: %s" code))
  (when (= 0 (slot :stock))
    (errorf "sold out: %s" (slot :name)))
  (put slot :stock (- (slot :stock) 1))
  (slot :name))

(defn try-dispense
  "(try-dispense machine code) -> string or nil; like dispense, nil instead of an error"
  [machine code]
  (try
    (dispense machine code)
    ([_] nil)))

(def coins-taken [10 20 50 100 200])

(defn insert-coins
  "(insert-coins coins) -> number; the total, errors with \"unknown coin\" for a bad coin"
  [coins]
  (var total 0)
  (each coin coins
    (assert (index-of coin coins-taken) "unknown coin")
    (+= total coin))
  total)

(defn restock-check
  "(restock-check machine code) -> string or :empty; like dispense, :empty when sold out"
  [machine code]
  (try
    (dispense machine code)
    ([err]
      (if (string/has-prefix? "sold out" err)
        :empty
        (error err)))))

(defn attempt
  "(attempt f) -> tuple; [:ok result] or [:error error-value] from calling f"
  [f]
  (def [ok value] (protect (f)))
  [(if ok :ok :error) value])
