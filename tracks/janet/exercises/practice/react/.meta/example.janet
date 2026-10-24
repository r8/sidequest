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
  @{:value value :dependents @[] :callbacks @{}})

(defn- compute [cell]
  ((cell :f) ;(map |($ :value) (cell :inputs))))

(defn compute-cell
  "(compute-cell f cells) -> a new compute cell whose value is (f ;(map value cells))"
  [f cells]
  (def cell @{:f f :inputs cells :dependents @[] :callbacks @{}})
  (each input cells (array/push (input :dependents) cell))
  (put cell :value (compute cell)))

(defn value
  "(value cell) -> the current value of cell"
  [cell]
  (cell :value))

(defn- downstream
  "The cells that depend on cell, directly or not, each after all the cells it depends on."
  [cell]
  (def seen @{})
  (def order @[])
  (defn visit [c]
    (unless (seen c)
      (put seen c true)
      (each d (c :dependents) (visit d))
      (array/push order c)))
  (each d (cell :dependents) (visit d))
  (reverse order))

(defn set-value
  "(set-value cell value) -> cell, an input cell now holding value, with every cell depending on it updated"
  [cell value]
  (put cell :value value)
  (def cells (downstream cell))
  (def before (tabseq [c :in cells] c (c :value)))
  (each c cells (put c :value (compute c)))
  # callbacks run only once every cell has settled
  (each c cells
    (unless (= (before c) (c :value))
      (eachk callback (c :callbacks) (callback (c :value)))))
  cell)

(defn add-callback
  "(add-callback cell callback) -> cell, which now calls callback when its value changes"
  [cell callback]
  (put-in cell [:callbacks callback] true)
  cell)

(defn remove-callback
  "(remove-callback cell callback) -> cell, which no longer calls callback (fine if it never did)"
  [cell callback]
  (put-in cell [:callbacks callback] nil)
  cell)
