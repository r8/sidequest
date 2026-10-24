(defn triplets-with-sum
  "(triplets-with-sum n) -> array of every [a b c] with a < b < c, a^2 + b^2 = c^2 and a + b + c = n, ordered by a"
  [n]
  # Substituting c = n - a - b into a^2 + b^2 = c^2 gives b = n(n - 2a) / 2(n - a).
  (seq [a :range [1 (/ n 3)]
        :let [b (/ (* n (- n (* 2 a))) (* 2 (- n a)))]
        :when (and (int? b) (< a b))]
    [a b (- n a b)]))
