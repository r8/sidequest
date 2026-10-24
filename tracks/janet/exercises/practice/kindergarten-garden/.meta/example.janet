# Plants are keywords: :grass, :clover, :radishes and :violets.

(def- students
  ["Alice" "Bob" "Charlie" "David" "Eve" "Fred"
   "Ginny" "Harriet" "Ileana" "Joseph" "Kincaid" "Larry"])

(def- plant-names
  {(chr "G") :grass (chr "C") :clover (chr "R") :radishes (chr "V") :violets})

(defn plants
  "(plants diagram student) -> the student's four plants as keywords, front row first"
  [diagram student]
  (def i (* 2 (index-of student students)))
  (mapcat |(map plant-names (slice $ i (+ i 2)))
          (string/split "\n" diagram)))
