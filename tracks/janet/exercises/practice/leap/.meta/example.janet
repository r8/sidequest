(defn- divisible? [n d] (zero? (% n d)))

(defn leap-year?
  "(leap-year? year) -> boolean"
  [year]
  (and (divisible? year 4)
       (or (not (divisible? year 100))
           (divisible? year 400))))
