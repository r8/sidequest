(defn score
  "(score x y) -> the points (0, 1, 5 or 10) for a dart landing at x, y"
  [x y]
  (def d2 (+ (* x x) (* y y))) # squared distance from the center
  (cond
    (<= d2 1) 10
    (<= d2 25) 5
    (<= d2 100) 1
    0))
