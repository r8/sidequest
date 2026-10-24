(defn same-record?
  "(same-record? a b) -> boolean; whether the two records hold the same contents"
  [a b]
  (deep= a b))

(defn seal
  "(seal record) -> struct; a copy of the record with nothing mutable at any level"
  [record]
  (freeze record))

(defn reopen
  "(reopen record) -> table; a copy of the record with everything mutable at every level"
  [record]
  (thaw record))

(defn copy-log
  "(copy-log log) -> array; a new array with the same names"
  [log]
  (array/slice log))

(defn add-note
  "(add-note record note) -> struct; a new record with the note added to its :notes"
  [record note]
  (struct ;(kvs record) :notes [;(get record :notes []) note]))
