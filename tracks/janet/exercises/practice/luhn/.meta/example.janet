# Digits and spaces only; captures the digits as numbers.
(def- digits-only
  (peg/compile '(* (any (+ :s (number :d))) -1)))

(defn- luhn-value
  "Every second digit from the right is doubled, minus 9 when that exceeds 9."
  [i digit]
  (if (odd? i)
    (let [d (* 2 digit)] (if (> d 9) (- d 9) d))
    digit))

(defn valid?
  "(valid? number) -> true when number (a string of digits and spaces) passes the Luhn check"
  [number]
  (if-let [digits (peg/match digits-only number)]
    (and (> (length digits) 1)
         (zero? (mod (sum (map luhn-value (range (length digits)) (reverse digits))) 10)))
    false))
