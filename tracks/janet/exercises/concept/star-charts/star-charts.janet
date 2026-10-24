(defn distance
  "(distance a b) -> number; the straight-line distance between two [x y] positions"
  [a b]
  (error "implement me"))

(defn label
  "(label star) -> string; \"<name> in <constellation>\""
  [star]
  (error "implement me"))

(defn headline
  "(headline stars) -> struct; {:brightest <name of the first star> :others <how many follow>}"
  [stars]
  (error "implement me"))

(defn shift
  "(shift star dx dy) -> struct; the star moved by dx and dy on the chart"
  [star dx dy]
  (error "implement me"))

(defn flip
  "(flip positions) -> array; each [x y] position mirrored to [x (- y)]"
  [positions]
  (error "implement me"))
