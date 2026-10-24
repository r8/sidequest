(defn rows
  "(rows letter) -> an array of the diamond's lines, widening from \"A\" to letter and back"
  [letter]
  (def n (- (letter 0) (chr "A")))
  (def top
    (seq [i :range-to [0 n]]
      (def line (buffer/new-filled (inc (* 2 n)) (chr " ")))
      (put line (- n i) (+ (chr "A") i))
      (put line (+ n i) (+ (chr "A") i))
      (string line)))
  @[;top ;(reverse (slice top 0 -2))])
