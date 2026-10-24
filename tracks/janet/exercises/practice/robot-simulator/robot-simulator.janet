# A robot is a mutable table {:position {:x x :y y} :direction direction}, where direction is
# :north, :east, :south or :west. North is +y and east is +x.
# Instructions are a string of R (turn right), L (turn left) and A (advance one step).

(defn make-robot
  "(make-robot position direction) -> a new robot at position {:x x :y y}, facing direction"
  [position direction]
  (error "implement me"))

(defn move
  "(move robot instructions) -> robot, after following each instruction in turn"
  [robot instructions]
  (error "implement me"))
