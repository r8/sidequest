(defn count-dolls
  "(count-dolls doll) -> integer; how many dolls the set has"
  [doll]
  (def inner (get doll 1))
  (if (nil? inner)
    1
    (+ 1 (count-dolls inner))))

(defn smallest
  "(smallest doll) -> number; the size of the solid doll at the centre"
  [doll]
  (def inner (get doll 1))
  (if (nil? inner)
    (first doll)
    (smallest inner)))

(defn sizes
  "(sizes doll) -> tuple; the sizes in the set, outermost first"
  [doll]
  (def inner (get doll 1))
  (if (nil? inner)
    [(first doll)]
    [(first doll) ;(sizes inner)]))

(defn nest
  "(nest sizes) -> doll or nil; the set assembled from the sizes, outermost first"
  [sizes]
  (if (empty? sizes)
    nil
    [(first sizes) (nest (slice sizes 1))]))

(defn closes?
  "(closes? doll) -> boolean; whether every doll is smaller than the one around it"
  [doll]
  (def inner (get doll 1))
  (or (nil? inner)
      (and (> (first doll) (first inner))
           (closes? inner))))
