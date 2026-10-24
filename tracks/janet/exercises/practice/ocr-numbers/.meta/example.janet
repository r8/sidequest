# The input is an array of rows; every digit is 3 columns wide and 4 rows tall.

(def- font
  [" _     _  _     _  _  _  _  _ "
   "| |  | _| _||_||_ |_   ||_||_|"
   "|_|  ||_  _|  | _||_|  ||_| _|"
   "                              "])

(defn- glyph
  "The 3x4 cell at column col of the four rows, as one string."
  [rows col]
  (string ;(map |(slice $ col (+ col 3)) rows)))

(def- digits
  (tabseq [d :range [0 10]] (glyph font (* 3 d)) (string d)))

(defn convert
  "(convert rows) -> the digits as a string, ? for an unreadable one and a comma between lines of digits; errors unless the grid is a multiple of 4 rows by 3 columns"
  [rows]
  (unless (zero? (mod (length rows) 4))
    (error "Number of input lines is not a multiple of four"))
  (unless (all |(zero? (mod (length $) 3)) rows)
    (error "Number of input columns is not a multiple of three"))
  (string/join
    (seq [line :in (partition 4 rows)]
      (string ;(seq [col :range [0 (length (line 0)) 3]]
                 (get digits (glyph line col) "?"))))
    ","))
