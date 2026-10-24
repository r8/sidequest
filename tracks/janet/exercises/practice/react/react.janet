# Cells are mutable tables. An input cell holds a value you set; a compute cell holds
# (f value1 value2 ...) of the cells it depends on, given in order:
#
#   (def a (input-cell 1))
#   (def b (compute-cell (fn [x] (* x 2)) [a]))
#   (def c (compute-cell + [a b]))   # 3
#
# A callback is a function of one argument. Callbacks are called with the cell's new value
# after a set-value, and only when that value differs from the one before the set-value.

(defn input-cell
  "(input-cell value) -> a new input cell holding value"
  [value]
  (error "implement me"))

(defn compute-cell
  "(compute-cell f cells) -> a new compute cell whose value is (f ;(map value cells))"
  [f cells]
  (error "implement me"))

(defn value
  "(value cell) -> the current value of cell"
  [cell]
  (error "implement me"))

(defn set-value
  "(set-value cell value) -> cell, an input cell now holding value, with every cell depending on it updated"
  [cell value]
  (error "implement me"))

(defn add-callback
  "(add-callback cell callback) -> cell, which now calls callback when its value changes"
  [cell callback]
  (error "implement me"))

(defn remove-callback
  "(remove-callback cell callback) -> cell, which no longer calls callback (fine if it never did)"
  [cell callback]
  (error "implement me"))
