# A stopwatch is a mutable table made by make-stopwatch; the other functions change or read it.
# Its state is :ready, :running or :stopped. Times are strings "HH:MM:SS", like "01:23:45".
# The stopwatch has no clock of its own: advance-time tells it how much time has passed.
# Inside, times are whole seconds.

(defn- parse-time [time]
  (def [h m s] (map scan-number (string/split ":" time)))
  (+ (* 3600 h) (* 60 m) s))

(defn- format-time [seconds]
  (string/format "%02d:%02d:%02d" (div seconds 3600) (mod (div seconds 60) 60) (mod seconds 60)))

(defn make-stopwatch
  "(make-stopwatch) -> a new stopwatch in the :ready state"
  []
  @{:state :ready :lap 0 :laps @[]})

(defn state
  "(state stopwatch) -> :ready, :running or :stopped"
  [stopwatch]
  (stopwatch :state))

(defn current-lap
  "(current-lap stopwatch) -> the time tracked in the current lap"
  [stopwatch]
  (format-time (stopwatch :lap)))

(defn total
  "(total stopwatch) -> the time tracked in all laps, including the current one"
  [stopwatch]
  (format-time (+ (stopwatch :lap) ;(stopwatch :laps))))

(defn previous-laps
  "(previous-laps stopwatch) -> the times of the finished laps, oldest first"
  [stopwatch]
  (map format-time (stopwatch :laps)))

(defn start
  "(start stopwatch) -> stopwatch, now running; errors unless it was ready or stopped"
  [stopwatch]
  (when (= :running (stopwatch :state)) (error "cannot start an already running stopwatch"))
  (put stopwatch :state :running))

(defn stop
  "(stop stopwatch) -> stopwatch, now stopped; errors unless it was running"
  [stopwatch]
  (unless (= :running (stopwatch :state)) (error "cannot stop a stopwatch that is not running"))
  (put stopwatch :state :stopped))

(defn lap
  "(lap stopwatch) -> stopwatch, with the current lap finished and a new one begun; errors unless it is running"
  [stopwatch]
  (unless (= :running (stopwatch :state)) (error "cannot lap a stopwatch that is not running"))
  (array/push (stopwatch :laps) (stopwatch :lap))
  (put stopwatch :lap 0))

(defn reset
  "(reset stopwatch) -> stopwatch, ready again with no laps; errors unless it was stopped"
  [stopwatch]
  (unless (= :stopped (stopwatch :state)) (error "cannot reset a stopwatch that is not stopped"))
  (merge-into stopwatch (make-stopwatch)))

(defn advance-time
  "(advance-time stopwatch by) -> stopwatch, with the time by (\"HH:MM:SS\") passed"
  [stopwatch by]
  (when (= :running (stopwatch :state))
    (update stopwatch :lap + (parse-time by)))
  stopwatch)
