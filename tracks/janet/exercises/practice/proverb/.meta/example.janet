(defn recite
  "(recite pieces) -> an array of the proverb's lines built from the list of pieces"
  [pieces]
  (if (empty? pieces)
    @[]
    (array/push
      (map |(string "For want of a " $0 " the " $1 " was lost.") pieces (slice pieces 1))
      (string "And all for the want of a " (first pieces) "."))))
