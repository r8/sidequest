# A character is a struct with the keys :strength :dexterity :constitution :intelligence
# :wisdom :charisma and :hitpoints.

(defn modifier
  "(modifier score) -> the ability modifier for a score: (score - 10) / 2, rounded down"
  [score]
  (math/floor (/ (- score 10) 2)))

(def- rng (math/rng (os/cryptorand 8)))

(defn ability
  "(ability) -> a random ability score: the sum of the highest three of four six-sided dice"
  []
  (def dice (sort (seq [_ :range [0 4]] (+ 1 (math/rng-int rng 6)))))
  (sum (slice dice 1)))

(defn character
  "(character) -> a random character with six abilities and 10 + the constitution modifier hitpoints"
  []
  (def abilities
    (tabseq [name :in [:strength :dexterity :constitution :intelligence :wisdom :charisma]]
      name (ability)))
  (put abilities :hitpoints (+ 10 (modifier (abilities :constitution))))
  (table/to-struct abilities))
