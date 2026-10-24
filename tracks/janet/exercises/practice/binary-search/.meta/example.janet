(defn find
  "(find items value) -> the index of value in the sorted items; errors when it is not there"
  [items value]
  # Search the half-open range [lo, hi).
  (defn search [lo hi]
    (when (>= lo hi) (error "value not in array"))
    (def mid (div (+ lo hi) 2))
    (def x (in items mid))
    (cond
      (< value x) (search lo mid)
      (> value x) (search (+ mid 1) hi)
      mid))
  (search 0 (length items)))
