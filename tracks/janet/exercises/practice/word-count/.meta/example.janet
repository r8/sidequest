# A word is a run of letters and digits, optionally joined by apostrophes (don't, you're).
# Everything else — punctuation, quotes around a word, whitespace — separates words.
(def- words
  (peg/compile ~(any (+ (<- (* :w+ (any (* "'" :w+)))) 1))))

(defn count-words
  "(count-words sentence) -> a table from each lower-cased word to its count"
  [sentence]
  (frequencies (peg/match words (string/ascii-lower sentence))))
