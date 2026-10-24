# Each piece names a thing and what it did to the thing named before it.
(def- pieces
  [["house that Jack built" ""]
   ["malt" "lay in"]
   ["rat" "ate"]
   ["cat" "killed"]
   ["dog" "worried"]
   ["cow with the crumpled horn" "tossed"]
   ["maiden all forlorn" "milked"]
   ["man all tattered and torn" "kissed"]
   ["priest all shaven and shorn" "married"]
   ["rooster that crowed in the morn" "woke"]
   ["farmer sowing his corn" "kept"]
   ["horse and the hound and the horn" "belonged to"]])

(defn- verse [n]
  (def chain (seq [i :down-to [(- n 1) 1]]
               (def [thing action] (pieces i))
               (string "the " thing " that " action " ")))
  (string "This is " ;chain "the " ((pieces 0) 0) "."))

(defn recite
  "(recite start-verse end-verse) -> an array of verses start-verse through end-verse, one string per verse"
  [start-verse end-verse]
  (map verse (range start-verse (+ end-verse 1))))
