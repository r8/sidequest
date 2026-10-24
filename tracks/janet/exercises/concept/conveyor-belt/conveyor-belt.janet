(defn make-belt
  "(make-belt boxes) -> fiber yielding each box in order"
  [boxes]
  (error "implement me"))

(defn next-box
  "(next-box belt) -> the next box, or nil when the belt is empty"
  [belt]
  (error "implement me"))

(defn unload
  "(unload belt) -> array of the boxes still on the belt"
  [belt]
  (error "implement me"))

(defn labels
  "(labels prefix) -> fiber yielding prefix-1, prefix-2, …"
  [prefix]
  (error "implement me"))

(defn make-scale
  "(make-scale) -> fiber; resumed with a weight, it returns the running total"
  []
  (error "implement me"))
