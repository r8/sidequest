# Clocks are values: add and subtract return new clocks. Two clocks showing the same time
# must be = to each other, so keep them normalized, e.g. a struct {:hour 8 :minute 5}.

(defn create
  "(create hour minute) -> a clock showing hour:minute, rolled over into a single day"
  [hour minute]
  # mod is never negative for a positive divisor, so negative times wrap around too
  (def minutes (mod (+ (* 60 hour) minute) (* 24 60)))
  {:hour (div minutes 60) :minute (mod minutes 60)})

(defn to-string
  "(to-string clock) -> the time as \"HH:MM\", like \"08:05\""
  [clock]
  (string/format "%02d:%02d" (clock :hour) (clock :minute)))

(defn add
  "(add clock minutes) -> a clock showing minutes later than clock"
  [clock minutes]
  (create (clock :hour) (+ (clock :minute) minutes)))

(defn subtract
  "(subtract clock minutes) -> a clock showing minutes earlier than clock"
  [clock minutes]
  (add clock (- minutes)))
