(defn- translate
  "Keeps only letters and digits, lower-cased, mirroring each letter in the alphabet."
  [text]
  (->> (string/ascii-lower text)
       (filter |(or (<= (chr "a") $ (chr "z")) (<= (chr "0") $ (chr "9"))))
       (map |(if (<= (chr "a") $ (chr "z")) (- (+ (chr "a") (chr "z")) $) $))
       (apply string/from-bytes)))

(defn encode
  "(encode plaintext) -> the ciphertext, lower-case, in space-separated groups of five"
  [plaintext]
  (string/join (partition 5 (translate plaintext)) " "))

(defn decode
  "(decode ciphertext) -> the plaintext, lower-case, without spaces"
  [ciphertext]
  (translate ciphertext))
