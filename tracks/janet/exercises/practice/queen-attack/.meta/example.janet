# A queen is a struct {:row row :column column}; rows and columns run from 0 to 7.

(defn create
  "(create row column) -> a queen at row, column; errors unless the position is on the board"
  [row column]
  (cond
    (neg? row) (error "row not positive")
    (> row 7) (error "row not on board")
    (neg? column) (error "column not positive")
    (> column 7) (error "column not on board"))
  {:row row :column column})

(defn can-attack?
  "(can-attack? white black) -> true when the two queens share a row, column or diagonal"
  [white black]
  (def rows (math/abs (- (white :row) (black :row))))
  (def columns (math/abs (- (white :column) (black :column))))
  (or (zero? rows) (zero? columns) (= rows columns)))
