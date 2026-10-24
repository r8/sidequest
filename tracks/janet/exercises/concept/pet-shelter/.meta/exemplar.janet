(def Pet
  @{:legs 4
    :introduce (fn [self] (string "Hi, I'm " (self :name) "!"))
    :speak (fn [self] (string (self :name) " makes a happy noise"))
    :feed (fn [self meals]
            (put self :meals (+ (self :meals) meals))
            self)})

(def Dog
  (table/setproto
    @{:speak (fn [self] (string (self :name) " says woof"))}
    Pet))

(def Bird
  (table/setproto
    @{:legs 2
      :speak (fn [self] (string (self :name) " says tweet"))}
    Pet))

(defn admit
  "(admit kind name) -> new pet table with :name and :meals 0, whose prototype is kind"
  [kind name]
  (table/setproto @{:name name :meals 0} kind))

(defn kind?
  "(kind? pet proto) -> true when proto is in pet's prototype chain, otherwise false"
  [pet proto]
  (var p (table/getproto pet))
  (while (and p (not= p proto))
    (set p (table/getproto p)))
  (= p proto))
