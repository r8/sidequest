(defn primes
  "(primes limit) -> array of the primes up to and including limit, in ascending order"
  [limit]
  (def composite (array/new-filled (inc limit) false))
  (seq [n :range-to [2 limit]
        :unless (composite n)]
    (loop [multiple :range-to [(* n n) limit n]]
      (put composite multiple true))
    n))
