(import test :as t)
(import ../pet-shelter :as sol)

# The prototypes are looked up when a test runs, so that the file loads before they are defined.
(defn proto [name] (eval (symbol "sol/" name)))

(t/deftest "1. a pet introduces itself"
  (t/assert-equal "Hi, I'm Biscuit!" (:introduce (table/setproto @{:name "Biscuit"} (proto "Pet")))))

(t/deftest "1. a pet makes a happy noise"
  (t/assert-equal "Biscuit makes a happy noise" (:speak (table/setproto @{:name "Biscuit"} (proto "Pet")))))

(t/deftest "1. a pet has four legs"
  (t/assert-equal 4 ((table/setproto @{:name "Biscuit"} (proto "Pet")) :legs)))

(t/deftest "1. a pet's own legs win"
  (t/assert-equal 3 ((table/setproto @{:name "Tripod" :legs 3} (proto "Pet")) :legs)))

(t/deftest "2. a dog says woof"
  (t/assert-equal "Rex says woof" (:speak (table/setproto @{:name "Rex"} (proto "Dog")))))

(t/deftest "2. a dog inherits introductions and legs"
  (def rex (table/setproto @{:name "Rex"} (proto "Dog")))
  (t/assert-equal ["Hi, I'm Rex!" 4] [(:introduce rex) (rex :legs)]))

(t/deftest "2. a bird says tweet and has two legs"
  (def kiwi (table/setproto @{:name "Kiwi"} (proto "Bird")))
  (t/assert-equal ["Kiwi says tweet" 2] [(:speak kiwi) (kiwi :legs)]))

(t/deftest "2. both kinds have Pet as their prototype"
  (t/assert-true (= (proto "Pet") (table/getproto (proto "Dog")) (table/getproto (proto "Bird")))))

(t/deftest "3. an admitted pet has a name and no meals yet"
  (def rex (sol/admit (proto "Dog") "Rex"))
  (t/assert-equal ["Rex" 0] [(rex :name) (rex :meals)]))

(t/deftest "3. an admitted pet behaves like its kind"
  (t/assert-equal "Kiwi says tweet" (:speak (sol/admit (proto "Bird") "Kiwi"))))

(t/deftest "3. its prototype is the kind"
  (t/assert-true (= (proto "Bird") (table/getproto (sol/admit (proto "Bird") "Kiwi")))))

(t/deftest "3. every pet is a new table"
  (def a (sol/admit (proto "Dog") "Rex"))
  (def b (sol/admit (proto "Dog") "Fido"))
  (t/assert-equal ["Rex" "Fido"] [(a :name) (b :name)]))

(t/deftest "4. feeding counts the meals"
  (def rex (sol/admit (proto "Dog") "Rex"))
  (:feed rex 2)
  (t/assert-equal 2 (rex :meals)))

(t/deftest "4. feedings can be chained"
  (def kiwi (sol/admit (proto "Bird") "Kiwi"))
  (:feed (:feed kiwi 1) 2)
  (t/assert-equal 3 (kiwi :meals)))

(t/deftest "4. feeding one pet leaves the others alone"
  (def rex (sol/admit (proto "Dog") "Rex"))
  (def fido (sol/admit (proto "Dog") "Fido"))
  (:feed rex 5)
  (t/assert-equal [5 0] [(rex :meals) (fido :meals)]))

(t/deftest "5. a dog is a dog"
  (t/assert-equal true (sol/kind? (sol/admit (proto "Dog") "Rex") (proto "Dog"))))

(t/deftest "5. a dog is a pet"
  (t/assert-equal true (sol/kind? (sol/admit (proto "Dog") "Rex") (proto "Pet"))))

(t/deftest "5. a dog is not a bird"
  (t/assert-equal false (sol/kind? (sol/admit (proto "Dog") "Rex") (proto "Bird"))))

(t/deftest "5. a table without a prototype is no kind"
  (t/assert-equal false (sol/kind? @{:name "Stray"} (proto "Pet"))))

(t/run)
