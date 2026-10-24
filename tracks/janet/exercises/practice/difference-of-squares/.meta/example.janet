(defn square-of-sum
  "(square-of-sum n) -> the square of the sum of 1..n"
  [n]
  (def s (sum (range 1 (inc n))))
  (* s s))

(defn sum-of-squares
  "(sum-of-squares n) -> the sum of the squares of 1..n"
  [n]
  (sum (map |(* $ $) (range 1 (inc n)))))

(defn difference-of-squares
  "(difference-of-squares n) -> (square-of-sum n) minus (sum-of-squares n)"
  [n]
  (- (square-of-sum n) (sum-of-squares n)))
