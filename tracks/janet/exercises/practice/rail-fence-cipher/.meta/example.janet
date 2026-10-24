(defn- fence-order
  "The positions 0..len-1 in the order the fence reads them: rail by rail, left to right."
  [len rails]
  (def cycle (* 2 (dec rails)))
  (defn rail [i]
    (def r (% i cycle))
    (min r (- cycle r)))
  # One rail never zig-zags (and its cycle is 0): the text reads straight through.
  (if (= rails 1)
    (range len)
    (sort-by |[(rail $) $] (range len))))

(defn encode
  "(encode text rails) -> text enciphered with a rail fence of that many rails"
  [text rails]
  (string/from-bytes ;(map text (fence-order (length text) rails))))

(defn decode
  "(decode text rails) -> text deciphered from a rail fence of that many rails"
  [text rails]
  (def plain (buffer/new-filled (length text)))
  (eachp [k i] (fence-order (length text) rails)
    (put plain i (text k)))
  (string plain))
