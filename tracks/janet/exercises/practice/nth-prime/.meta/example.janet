(defn prime
  "(prime number) -> the nth prime number, counting 2 as the first"
  [number]
  (when (< number 1) (error "there is no zeroth prime"))
  (def primes @[2])
  (var candidate 1)
  (while (< (length primes) number)
    (+= candidate 2)
    # a candidate is prime when no smaller prime up to its square root divides it
    (when (all |(pos? (% candidate $)) (take-while |(<= (* $ $) candidate) primes))
      (array/push primes candidate)))
  (primes (dec number)))
