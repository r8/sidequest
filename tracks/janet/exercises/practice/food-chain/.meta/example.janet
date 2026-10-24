(def- fly-line "I don't know why she swallowed the fly. Perhaps she'll die.")

# [animal, the line after she swallows it, how it is named when something is swallowed to catch it]
(def- animals
  [["fly" fly-line "fly"]
   ["spider" "It wriggled and jiggled and tickled inside her."
    "spider that wriggled and jiggled and tickled inside her"]
   ["bird" "How absurd to swallow a bird!" "bird"]
   ["cat" "Imagine that, to swallow a cat!" "cat"]
   ["dog" "What a hog, to swallow a dog!" "dog"]
   ["goat" "Just opened her throat and swallowed a goat!" "goat"]
   ["cow" "I don't know how she swallowed a cow!" "cow"]
   ["horse" "She's dead, of course!" "horse"]])

(defn- verse [n]
  (def [animal remark] (animals (- n 1)))
  (def opening [(string "I know an old lady who swallowed a " animal ".") remark])
  (if (or (= n 1) (= n (length animals)))
    opening
    [;opening
     ;(seq [i :down-to [(- n 1) 1]]
        (string "She swallowed the " ((animals i) 0) " to catch the " ((animals (- i 1)) 2) "."))
     fly-line]))

(defn recite
  "(recite start-verse end-verse) -> an array of the lines of verses start-verse through end-verse, with an empty line between verses"
  [start-verse end-verse]
  (def verses (map verse (range start-verse (+ end-verse 1))))
  (array/slice (mapcat |["" ;$] verses) 1))
