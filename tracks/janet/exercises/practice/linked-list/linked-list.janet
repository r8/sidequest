# A list is a mutable table made by make-list; the other functions change or read it.
# Build it from linked nodes, each pointing to the one before and after it, rather than an array.

(defn make-list
  "(make-list) -> a new empty list"
  []
  (error "implement me"))

(defn push
  "(push list value) -> list, with value added at the end"
  [list value]
  (error "implement me"))

(defn pop
  "(pop list) -> the value at the end, removed from list"
  [list]
  (error "implement me"))

(defn shift
  "(shift list) -> the value at the start, removed from list"
  [list]
  (error "implement me"))

(defn unshift
  "(unshift list value) -> list, with value added at the start"
  [list value]
  (error "implement me"))

(defn size
  "(size list) -> the number of values in list"
  [list]
  (error "implement me"))

(defn delete
  "(delete list value) -> list, without the first node holding value (unchanged if there is none)"
  [list value]
  (error "implement me"))
