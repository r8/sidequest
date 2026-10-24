# Nine digits, then a check digit that may be X (ten); captures the ten values.
(def- isbn-10
  (peg/compile '(* (9 (number :d)) (+ (number :d) (/ "X" 10)) -1)))

(defn valid?
  "(valid? isbn) -> true when isbn is a valid ISBN-10, with or without dashes"
  [isbn]
  (if-let [digits (peg/match isbn-10 (string/replace-all "-" "" isbn))]
    (zero? (mod (sum (map * digits (range 10 0 -1))) 11))
    false))
