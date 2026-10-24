(defn- next-row [row]
  [1 ;(map + row (drop 1 row)) 1])

(defn rows
  "(rows count) -> the first count rows of Pascal's triangle, each a list of numbers"
  [count]
  (var row [1])
  (seq [_ :range [0 count]]
    (def current row)
    (set row (next-row row))
    current))
