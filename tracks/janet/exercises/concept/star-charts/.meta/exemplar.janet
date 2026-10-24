(defn distance
  "(distance a b) -> number; the straight-line distance between two [x y] positions"
  [[x1 y1] [x2 y2]]
  (def dx (- x2 x1))
  (def dy (- y2 y1))
  (math/sqrt (+ (* dx dx) (* dy dy))))

(defn label
  "(label star) -> string; \"<name> in <constellation>\""
  [{:name name :constellation constellation}]
  (string name " in " constellation))

(defn headline
  "(headline stars) -> struct; {:brightest <name of the first star> :others <how many follow>}"
  [[{:name brightest} & others]]
  {:brightest brightest :others (length others)})

(defn shift
  "(shift star dx dy) -> struct; the star moved by dx and dy on the chart"
  [{:name name :constellation constellation :magnitude magnitude :position [x y]} dx dy]
  {:name name
   :constellation constellation
   :magnitude magnitude
   :position [(+ x dx) (+ y dy)]})

(defn flip
  "(flip positions) -> array; each [x y] position mirrored to [x (- y)]"
  [positions]
  (map (fn [[x y]] [x (- y)]) positions))
