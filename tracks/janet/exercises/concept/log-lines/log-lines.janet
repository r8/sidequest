(defn level
  "(level line) -> :info, :warn or :error from the line's [LEVEL] prefix, or nil"
  [line]
  (error "implement me"))

(defn timestamp
  "(timestamp line) -> [hours minutes] of the line's time, as numbers"
  [line]
  (error "implement me"))

(defn trams
  "(trams log) -> array of the tram numbers mentioned in the log, as strings"
  [log]
  (error "implement me"))

(defn redact
  "(redact line) -> string with every \"badge <digits>\" replaced by \"badge [redacted]\""
  [line]
  (error "implement me"))

(defn first-error
  "(first-error log) -> position where the first [ERROR] line starts, or nil"
  [log]
  (error "implement me"))
