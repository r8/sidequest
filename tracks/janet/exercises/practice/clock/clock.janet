# Clocks are values: add and subtract return new clocks. Two clocks showing the same time
# must be = to each other, so keep them normalized, e.g. a struct {:hour 8 :minute 5}.

(defn create
  "(create hour minute) -> a clock showing hour:minute, rolled over into a single day"
  [hour minute]
  (error "implement me"))

(defn to-string
  "(to-string clock) -> the time as \"HH:MM\", like \"08:05\""
  [clock]
  (error "implement me"))

(defn add
  "(add clock minutes) -> a clock showing minutes later than clock"
  [clock minutes]
  (error "implement me"))

(defn subtract
  "(subtract clock minutes) -> a clock showing minutes earlier than clock"
  [clock minutes]
  (error "implement me"))
