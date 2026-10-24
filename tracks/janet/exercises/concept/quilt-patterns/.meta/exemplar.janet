(defn checkerboard
  "(checkerboard rows cols) -> array of rows of :light and :dark, :light in the top-left corner"
  [rows cols]
  (seq [r :range [0 rows]]
    (seq [c :range [0 cols]]
      (if (even? (+ r c)) :light :dark))))

(defn border-patches
  "(border-patches rows cols) -> array of the [row col] positions on the edge, in reading order"
  [rows cols]
  (seq [r :range [0 rows]
        c :range [0 cols]
        :when (or (= r 0) (= r (dec rows)) (= c 0) (= c (dec cols)))]
    [r c]))

(defn fabric-needed
  "(fabric-needed quilt) -> table from each colour to its number of patches"
  [quilt]
  (def counts @{})
  (loop [row :in quilt
         patch :in row]
    (put counts patch (inc (get counts patch 0))))
  counts)

(defn palette-index
  "(palette-index palette) -> table from each colour to its position in the palette"
  [palette]
  (tabseq [[i colour] :pairs palette] colour i))

(defn repeat-strip
  "(repeat-strip strip times) -> array of the strip's colours, repeated times times"
  [strip times]
  (catseq [_ :range [0 times]] strip))
