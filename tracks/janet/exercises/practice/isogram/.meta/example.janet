(defn- letter? [c] (<= (chr "a") c (chr "z")))

(defn isogram?
  "(isogram? phrase) -> boolean"
  [phrase]
  (def letters (filter letter? (string/ascii-lower phrase)))
  (= (length letters) (length (distinct letters))))
