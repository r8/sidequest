(defn- divisor-sum
  "The sum of all divisors of n, n included; divisors come in pairs d and n/d around the square root."
  [n]
  (sum (seq [d :range-to [1 (math/floor (math/sqrt n))]
             :when (zero? (% n d))
             :let [pair (/ n d)]]
         (if (= d pair) d (+ d pair)))))

(defn classify
  "(classify n) -> :perfect, :abundant or :deficient; errors unless n is a positive integer"
  [n]
  (unless (pos? n)
    (error "Classification is only possible for positive integers."))
  (case (cmp (- (divisor-sum n) n) n)
    -1 :deficient
    0 :perfect
    1 :abundant))
