# Capture the first letter of every run of letters; an apostrophe doesn't end a word (Halley's).
(def- initials
  (peg/compile ~(any (+ (* (<- :a) (any (+ :a "'"))) 1))))

(defn abbreviate
  "(abbreviate phrase) -> the upper-cased acronym of phrase"
  [phrase]
  (string/ascii-upper (string/join (peg/match initials phrase))))
