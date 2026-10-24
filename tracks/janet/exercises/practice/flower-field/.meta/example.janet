# A garden is a tuple of row strings; "*" is a flower and " " an empty square.

(defn annotate
  "(annotate garden) -> the garden with each empty square showing its count of adjacent flowers, if any"
  [garden]
  (defn flowers [r c]
    (count |(= (chr "*") $)
           (seq [dr :in [-1 0 1] dc :in [-1 0 1]]
             (get-in garden [(+ r dr) (+ c dc)]))))
  (seq [[r row] :pairs garden]
    (string/join
      (seq [[c square] :pairs row]
        (def n (flowers r c))
        (cond
          (= square (chr "*")) "*"
          (zero? n) " "
          (string n))))))
