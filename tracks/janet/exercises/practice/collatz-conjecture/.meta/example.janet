(defn steps
  "(steps number) -> the number of Collatz steps it takes to reach 1; errors unless number is positive"
  [number]
  (unless (pos? number)
    (error "Only positive integers are allowed"))
  (if (= number 1)
    0
    (inc (steps (if (even? number) (/ number 2) (inc (* 3 number)))))))
