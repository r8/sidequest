(defn distance
  "(distance strand1 strand2) -> integer; errors unless the strands have equal length"
  [strand1 strand2]
  (unless (= (length strand1) (length strand2))
    (error "strands must be of equal length"))
  (count false? (map = strand1 strand2)))
