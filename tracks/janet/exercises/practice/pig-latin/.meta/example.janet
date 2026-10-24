# Splits a word into the head that moves to the end and the rest.
(def- word
  (peg/compile
    ~{:vowel (set "aeiou")
      # Leading consonants; a "qu" travels with them, and a "y" after the first letter acts as a vowel.
      :consonants (* (? (if-not (+ :vowel "qu") 1))
                     (any (if-not (+ :vowel "qu" "y") 1))
                     (? "qu"))
      :head (+ (if (+ :vowel "xr" "yt") 0) :consonants)
      :main (* (<- :head) (<- (any 1)))}))

(defn- translate-word [w]
  (def [head rest] (peg/match word w))
  (string rest head "ay"))

(defn translate
  "(translate phrase) -> the phrase with every word translated to Pig Latin, the spacing kept"
  [phrase]
  (string (peg/replace-all '(some :S) translate-word phrase)))
