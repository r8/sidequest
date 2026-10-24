(def- m 26)

(defn- check-key [a]
  (unless (= 1 (math/gcd a m))
    (error "a and m must be coprime.")))

(defn- translate
  "Keeps the letters and digits of text, lower-cased, mapping each letter's index through f."
  [text f]
  (string/from-bytes
    ;(seq [c :in (string/ascii-lower text)
           :when (or (<= (chr "a") c (chr "z")) (<= (chr "0") c (chr "9")))]
       (if (<= (chr "a") c (chr "z"))
         (+ (chr "a") (mod (f (- c (chr "a"))) m))
         c))))

(defn encode
  "(encode text a b) -> the letters and digits of text, letters enciphered with key (a, b), in groups of five; errors unless a is coprime to 26"
  [text a b]
  (check-key a)
  (def ciphered (translate text |(+ (* a $) b)))
  (string/join (peg/match ~(any (<- (between 1 5 1))) ciphered) " "))

(defn decode
  "(decode text a b) -> the letters and digits of text, letters deciphered with key (a, b); errors unless a is coprime to 26"
  [text a b]
  (check-key a)
  (def a-inverse (find |(= 1 (mod (* a $) m)) (range m)))
  (translate text |(* a-inverse (- $ b))))
