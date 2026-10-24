(defn square-root
  "(square-root radicand) -> the integer square root of a perfect square"
  [radicand]
  # Newton's method on integers, starting from above the root.
  (var x radicand)
  (while (> (* x x) radicand)
    (set x (div (+ x (div radicand x)) 2)))
  x)
