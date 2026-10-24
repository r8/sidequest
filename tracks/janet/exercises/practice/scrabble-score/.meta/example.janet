(def- letter-values
  (tabseq [[letters value] :in [["AEIOULNRST" 1] ["DG" 2] ["BCMP" 3] ["FHVWY" 4]
                                ["K" 5] ["JX" 8] ["QZ" 10]]
           letter :in letters]
    letter value))

(defn score
  "(score word) -> the Scrabble score of word, ignoring case"
  [word]
  (sum (map letter-values (string/ascii-upper word))))
