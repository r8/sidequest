(def level-pattern
  (peg/compile ~(* "[" (<- (+ "INFO" "WARN" "ERROR")) "]")))

(def time-pattern
  (peg/compile ~(* (thru "] ") (<- (2 :d)) ":" (<- (2 :d)))))

(def tram-pattern
  (peg/compile ~(any (+ (* "tram " (<- :d+)) 1))))

(defn level
  "(level line) -> :info, :warn or :error from the line's [LEVEL] prefix, or nil"
  [line]
  (def captures (peg/match level-pattern line))
  (when captures
    (keyword (string/ascii-lower (captures 0)))))

(defn timestamp
  "(timestamp line) -> [hours minutes] of the line's time, as numbers"
  [line]
  (def captures (peg/match time-pattern line))
  [(scan-number (captures 0)) (scan-number (captures 1))])

(defn trams
  "(trams log) -> array of the tram numbers mentioned in the log, as strings"
  [log]
  (peg/match tram-pattern log))

(defn redact
  "(redact line) -> string with every \"badge <digits>\" replaced by \"badge [redacted]\""
  [line]
  (string (peg/replace-all ~(* "badge " :d+) "badge [redacted]" line)))

(defn first-error
  "(first-error log) -> position where the first [ERROR] line starts, or nil"
  [log]
  (peg/find "[ERROR]" log))
