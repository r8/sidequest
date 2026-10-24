(defn factors
  "(factors n) -> array of the prime factors of n in ascending order, repeated by multiplicity"
  [n]
  (def result @[])
  (var n n)
  (var d 2)
  (while (> n 1)
    (cond
      # No divisor up to the square root: what is left is prime.
      (> (* d d) n) (do (array/push result n) (set n 1))
      (zero? (% n d)) (do (array/push result d) (set n (/ n d)))
      (++ d)))
  result)
