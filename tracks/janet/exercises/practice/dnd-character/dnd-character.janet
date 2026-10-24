# A character is a struct with the keys :strength :dexterity :constitution :intelligence
# :wisdom :charisma and :hitpoints.

(defn modifier
  "(modifier score) -> the ability modifier for a score: (score - 10) / 2, rounded down"
  [score]
  (error "implement me"))

(defn ability
  "(ability) -> a random ability score: the sum of the highest three of four six-sided dice"
  []
  (error "implement me"))

(defn character
  "(character) -> a random character with six abilities and 10 + the constitution modifier hitpoints"
  []
  (error "implement me"))
