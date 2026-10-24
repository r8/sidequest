(import test :as t)
(import ../seed-catalog :as sol)

(def catalog
  [{:name "Cherry Belle" :crop :radish :days 25}
   {:name "Nantes" :crop :carrot :days 70}
   {:name "Little Gem" :crop :lettuce :days 50}
   {:name "French Breakfast" :crop :radish :days 28}])

(def autumn
  @[{:name "Winter Density" :crop :lettuce :days 60}
    {:name "Black Spanish" :crop :radish :days 55}
    {:name "Autumn King" :crop :carrot :days 85}
    {:name "Arctic King" :crop :lettuce :days 65}
    {:name "Paris Market" :crop :carrot :days 65}])

(t/deftest "1. the names of a catalogue"
  (t/assert-equal ["Cherry Belle" "Nantes" "Little Gem" "French Breakfast"] (sol/seed-names catalog)))

(t/deftest "1. the names of a catalogue in an array"
  (t/assert-equal ["Winter Density" "Black Spanish" "Autumn King" "Arctic King" "Paris Market"] (sol/seed-names autumn)))

(t/deftest "1. an empty catalogue has no names"
  (t/assert-equal [] (sol/seed-names [])))

(t/deftest "2. seeds ready within 30 days"
  (t/assert-equal [{:name "Cherry Belle" :crop :radish :days 25}
                   {:name "French Breakfast" :crop :radish :days 28}]
                  (sol/quick-seeds catalog 30)))

(t/deftest "2. a seed ready on the last day counts"
  (t/assert-equal [{:name "Cherry Belle" :crop :radish :days 25}] (sol/quick-seeds catalog 25)))

(t/deftest "2. no seed is that quick"
  (t/assert-equal [] (sol/quick-seeds autumn 50)))

(t/deftest "2. the catalogue does not change"
  (def seeds @[{:name "Nantes" :crop :carrot :days 70} {:name "Cherry Belle" :crop :radish :days 25}])
  (sol/quick-seeds seeds 30)
  (t/assert-equal [{:name "Nantes" :crop :carrot :days 70} {:name "Cherry Belle" :crop :radish :days 25}] seeds))

(t/deftest "3. two varieties of radish"
  (t/assert-equal 2 (sol/count-crop catalog :radish)))

(t/deftest "3. one variety of carrot"
  (t/assert-equal 1 (sol/count-crop catalog :carrot)))

(t/deftest "3. no variety of a crop not in the catalogue"
  (t/assert-equal 0 (sol/count-crop catalog :leek)))

(t/deftest "4. the longest wait in a catalogue"
  (t/assert-equal 70 (sol/longest-wait catalog)))

(t/deftest "4. the longest wait is not always at the end"
  (t/assert-equal 85 (sol/longest-wait autumn)))

(t/deftest "4. an empty catalogue has no wait"
  (t/assert-equal 0 (sol/longest-wait [])))

(t/deftest "5. every seed is ready within 70 days"
  (t/assert-equal true (sol/all-quick? catalog 70)))

(t/deftest "5. not every seed is ready within 60 days"
  (t/assert-equal false (sol/all-quick? catalog 60)))

(t/deftest "5. an empty catalogue is all quick"
  (t/assert-equal true (sol/all-quick? [] 10)))

(t/run)
