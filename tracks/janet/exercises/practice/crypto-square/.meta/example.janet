(defn ciphertext
  "(ciphertext plaintext) -> the square code of the normalized text, its columns joined by spaces"
  [plaintext]
  (def text (string/ascii-lower (string/join (peg/match ~(any (+ (<- :w) 1)) plaintext))))
  (def columns (math/ceil (math/sqrt (length text))))
  (def rows (if (zero? columns) 0 (math/ceil (/ (length text) columns))))
  # read the rectangle column by column, padding the short last row with spaces
  (string/join
    (seq [c :range [0 columns]]
      (string/from-bytes ;(seq [r :range [0 rows]] (get text (+ c (* r columns)) (chr " ")))))
    " "))
