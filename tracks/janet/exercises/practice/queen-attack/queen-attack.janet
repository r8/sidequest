# A queen is a struct {:row row :column column}; rows and columns run from 0 to 7.

(defn create
  "(create row column) -> a queen at row, column; errors unless the position is on the board"
  [row column]
  (error "implement me"))

(defn can-attack?
  "(can-attack? white black) -> true when the two queens share a row, column or diagonal"
  [white black]
  (error "implement me"))
