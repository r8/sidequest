# Define the prototypes Pet, Dog and Bird here.

(defn admit
  "(admit kind name) -> new pet table with :name and :meals 0, whose prototype is kind"
  [kind name]
  (error "implement me"))

(defn kind?
  "(kind? pet proto) -> true when proto is in pet's prototype chain, otherwise false"
  [pet proto]
  (error "implement me"))
