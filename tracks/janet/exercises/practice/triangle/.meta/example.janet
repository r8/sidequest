(defn- triangle? [a b c]
  (def [x y z] (sort @[a b c]))
  (and (pos? x) (>= (+ x y) z)))

(defn- distinct-sides [a b c]
  (length (distinct [a b c])))

(defn equilateral?
  "(equilateral? a b c) -> true when the sides form a triangle with all three sides equal"
  [a b c]
  (and (triangle? a b c) (= 1 (distinct-sides a b c))))

(defn isosceles?
  "(isosceles? a b c) -> true when the sides form a triangle with at least two sides equal"
  [a b c]
  (and (triangle? a b c) (<= (distinct-sides a b c) 2)))

(defn scalene?
  "(scalene? a b c) -> true when the sides form a triangle with all three sides different"
  [a b c]
  (and (triangle? a b c) (= 3 (distinct-sides a b c))))
