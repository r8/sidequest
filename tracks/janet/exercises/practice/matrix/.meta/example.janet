# Rows and columns are numbered from 1.

(defn- parse [s]
  (map |(map scan-number (string/split " " $)) (string/split "\n" s)))

(defn row
  "(row matrix index) -> the numbers in row index of matrix, a string with one row per line"
  [matrix index]
  ((parse matrix) (dec index)))

(defn column
  "(column matrix index) -> the numbers in column index of matrix, a string with one row per line"
  [matrix index]
  (map |($ (dec index)) (parse matrix)))
