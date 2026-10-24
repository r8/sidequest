(defn checkerboard
  "(checkerboard rows cols) -> array of rows of :light and :dark, :light in the top-left corner"
  [rows cols]
  (error "implement me"))

(defn border-patches
  "(border-patches rows cols) -> array of the [row col] positions on the edge, in reading order"
  [rows cols]
  (error "implement me"))

(defn fabric-needed
  "(fabric-needed quilt) -> table from each colour to its number of patches"
  [quilt]
  (error "implement me"))

(defn palette-index
  "(palette-index palette) -> table from each colour to its position in the palette"
  [palette]
  (error "implement me"))

(defn repeat-strip
  "(repeat-strip strip times) -> array of the strip's colours, repeated times times"
  [strip times]
  (error "implement me"))
