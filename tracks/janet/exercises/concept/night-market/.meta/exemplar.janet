(defn open?
  "(open? hour) -> boolean; whether the market is open during the hour"
  [hour]
  (or (>= hour 18) (< hour 2)))

(defn can-enter?
  "(can-enter? age with-adult) -> boolean; whether the visitor may enter"
  [age with-adult]
  (or (>= age 16) with-adult))

(defn stall-fee
  "(stall-fee size) -> integer; the nightly fee for a stall of that size"
  [size]
  (case size
    "small" 10
    "medium" 15
    "large" 25
    0))

(defn lantern-color
  "(lantern-color visitors) -> string; \"green\", \"amber\" or \"red\""
  [visitors]
  (cond
    (< visitors 50) "green"
    (< visitors 200) "amber"
    "red"))

(defn closing-call
  "(closing-call hour) -> string or nil; the announcement made during the hour"
  [hour]
  (when (= hour 1)
    "Last orders!"))
