(defn- letter? [c] (<= (chr "a") c (chr "z")))

(defn pangram?
  "(pangram? sentence) -> true when sentence uses every letter of the alphabet, ignoring case"
  [sentence]
  (= 26 (length (distinct (filter letter? (string/ascii-lower sentence))))))
