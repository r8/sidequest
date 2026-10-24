# A robot is a mutable table {:position {:x x :y y} :direction direction}, where direction is
# :north, :east, :south or :west. North is +y and east is +x.
# Instructions are a string of R (turn right), L (turn left) and A (advance one step).

(def- right {:north :east :east :south :south :west :west :north})
(def- left (invert right))
(def- steps {:north [0 1] :east [1 0] :south [0 -1] :west [-1 0]})

(defn make-robot
  "(make-robot position direction) -> a new robot at position {:x x :y y}, facing direction"
  [position direction]
  @{:position position :direction direction})

(defn- advance [{:x x :y y} [dx dy]]
  {:x (+ x dx) :y (+ y dy)})

(defn move
  "(move robot instructions) -> robot, after following each instruction in turn"
  [robot instructions]
  (each instruction instructions
    (case instruction
      (chr "R") (update robot :direction right)
      (chr "L") (update robot :direction left)
      (chr "A") (put robot :position (advance (robot :position) (steps (robot :direction))))))
  robot)
