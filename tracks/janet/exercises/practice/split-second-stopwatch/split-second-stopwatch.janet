# A stopwatch is a mutable table made by make-stopwatch; the other functions change or read it.
# Its state is :ready, :running or :stopped. Times are strings "HH:MM:SS", like "01:23:45".
# The stopwatch has no clock of its own: advance-time tells it how much time has passed.

(defn make-stopwatch
  "(make-stopwatch) -> a new stopwatch in the :ready state"
  []
  (error "implement me"))

(defn state
  "(state stopwatch) -> :ready, :running or :stopped"
  [stopwatch]
  (error "implement me"))

(defn current-lap
  "(current-lap stopwatch) -> the time tracked in the current lap"
  [stopwatch]
  (error "implement me"))

(defn total
  "(total stopwatch) -> the time tracked in all laps, including the current one"
  [stopwatch]
  (error "implement me"))

(defn previous-laps
  "(previous-laps stopwatch) -> the times of the finished laps, oldest first"
  [stopwatch]
  (error "implement me"))

(defn start
  "(start stopwatch) -> stopwatch, now running; errors unless it was ready or stopped"
  [stopwatch]
  (error "implement me"))

(defn stop
  "(stop stopwatch) -> stopwatch, now stopped; errors unless it was running"
  [stopwatch]
  (error "implement me"))

(defn lap
  "(lap stopwatch) -> stopwatch, with the current lap finished and a new one begun; errors unless it is running"
  [stopwatch]
  (error "implement me"))

(defn reset
  "(reset stopwatch) -> stopwatch, ready again with no laps; errors unless it was stopped"
  [stopwatch]
  (error "implement me"))

(defn advance-time
  "(advance-time stopwatch by) -> stopwatch, with the time by (\"HH:MM:SS\") passed"
  [stopwatch by]
  (error "implement me"))
