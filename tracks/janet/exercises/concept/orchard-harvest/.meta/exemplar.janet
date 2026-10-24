(def crate-size 24)

(defn crates
  "(crates apples) -> integer; the number of completely filled crates"
  [apples]
  (div apples crate-size))

(defn leftover
  "(leftover apples) -> integer; the apples left over after filling the crates"
  [apples]
  (mod apples crate-size))

(defn crates-needed
  "(crates-needed apples) -> integer; the crates it takes to hold every apple"
  [apples]
  (math/ceil (/ apples crate-size)))

(defn average-weight
  "(average-weight total-grams apples) -> number; the average weight of one apple"
  [total-grams apples]
  (/ total-grams apples))

(defn round-to-cents
  "(round-to-cents amount) -> number; the amount rounded to two decimal places"
  [amount]
  (/ (math/round (* amount 100)) 100))
