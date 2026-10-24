(defn badge
  "(badge full-name department) -> string; the name with the department in capitals"
  [full-name department]
  (string full-name " (" (string/ascii-upper department) ")"))

(defn surname-start
  "(surname-start full-name) -> integer; the index where the surname begins"
  [full-name]
  (+ 1 (string/find " " full-name)))

(defn initials
  "(initials full-name) -> string; the initials, each followed by a full stop"
  [full-name]
  (def start (surname-start full-name))
  (string (string/slice full-name 0 1) "." (string/slice full-name start (+ start 1)) "."))

(defn surname
  "(surname full-name) -> string; everything after the first space"
  [full-name]
  (string/slice full-name (surname-start full-name)))

(defn name-tag
  "(name-tag full-name) -> string; the name in a 24-character tag"
  [full-name]
  (string/format "| %-20.20s |" full-name))

(defn doctor?
  "(doctor? full-name) -> boolean; whether the name starts with \"Dr. \""
  [full-name]
  (string/has-prefix? "Dr. " full-name))
