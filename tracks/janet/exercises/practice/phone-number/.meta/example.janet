(defn clean
  "(clean phone-number) -> the ten-digit NANP number as a string of digits"
  [phone-number]
  (when (peg/find :a phone-number) (error "letters not permitted"))
  (when (peg/find ~(if-not (+ :d (set " ()-.+")) 1) phone-number)
    (error "punctuations not permitted"))
  (def digits (string/join (peg/match ~(any (+ (<- :d) 1)) phone-number)))
  (def n (length digits))
  (cond
    (< n 10) (error "must not be fewer than 10 digits")
    (> n 11) (error "must not be greater than 11 digits")
    (and (= n 11) (not= (digits 0) (chr "1"))) (error "11 digits must start with 1"))
  (def number (string/slice digits -11))
  (each [part i] [["area code" 0] ["exchange code" 3]]
    (case (number i)
      (chr "0") (error (string part " cannot start with zero"))
      (chr "1") (error (string part " cannot start with one"))))
  number)
