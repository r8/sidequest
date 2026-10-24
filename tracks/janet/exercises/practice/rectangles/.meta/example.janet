(defn count-rectangles
  "(count-rectangles lines) -> the number of rectangles drawn with + - | in the lines"
  [lines]
  (defn at [r c] (get-in lines [r c]))
  (defn edge? [allowed cells] (all |(index-of $ allowed) cells))
  (defn horizontal? [r c1 c2] (edge? "-+" (seq [c :range-to [c1 c2]] (at r c))))
  (defn vertical? [c r1 r2] (edge? "|+" (seq [r :range-to [r1 r2]] (at r c))))
  (def corners
    (seq [[r line] :pairs lines
          c :range [0 (length line)]
          :when (= (chr "+") (line c))]
      [r c]))
  # Each pair of top-left and bottom-right corners whose four sides are all drawn is a rectangle.
  # The other two corners must then be +, since only + belongs to both a horizontal and a vertical side.
  (length
    (seq [[r1 c1] :in corners
          [r2 c2] :in corners
          :when (and (> r2 r1) (> c2 c1)
                     (horizontal? r1 c1 c2) (horizontal? r2 c1 c2)
                     (vertical? c1 r1 r2) (vertical? c2 r1 r2))]
      true)))
