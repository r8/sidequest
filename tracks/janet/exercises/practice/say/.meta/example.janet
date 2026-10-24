(def- small
  ["zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"
   "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"])

(def- tens
  [nil nil "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"])

(def- scales
  [[1_000_000_000 "billion"] [1_000_000 "million"] [1_000 "thousand"] [100 "hundred"]])

(defn say
  "(say n) -> n spelled out in English; errors unless 0 <= n <= 999,999,999,999"
  [n]
  (unless (<= 0 n 999_999_999_999)
    (error "input out of range"))
  (cond
    (< n 20) (small n)
    (< n 100) (let [ten (tens (div n 10))
                    unit (% n 10)]
                (if (zero? unit) ten (string ten "-" (small unit))))
    (let [[size name] (find |(>= n (first $)) scales)
          rest (% n size)]
      (string (say (div n size)) " " name
              (if (zero? rest) "" (string " " (say rest)))))))
