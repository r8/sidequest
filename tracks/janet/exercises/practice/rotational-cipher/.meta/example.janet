(defn- rotate-byte [shift c]
  (defn from [base]
    (+ base (mod (+ (- c base) shift) 26)))
  (cond
    (<= (chr "a") c (chr "z")) (from (chr "a"))
    (<= (chr "A") c (chr "Z")) (from (chr "A"))
    c))

(defn rotate
  "(rotate text shift) -> text with every letter shifted by shift places, keeping case"
  [text shift]
  (string/from-bytes ;(map |(rotate-byte shift $) text)))
