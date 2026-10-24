(import test :as t)
(import ../train-cars :as sol)

(t/deftest "1. couple a car to a train"
  (t/assert-equal @["engine" "coal" "mail"] (sol/couple-car @["engine" "coal"] "mail")))

(t/deftest "1. couple a car to a lone engine"
  (t/assert-equal @["engine" "tank"] (sol/couple-car @["engine"] "tank")))

(t/deftest "1. coupling changes the train itself"
  (def train @["engine"])
  (sol/couple-car train "mail")
  (t/assert-equal @["engine" "mail"] train))

(t/deftest "2. uncouple the last car"
  (t/assert-equal "mail" (sol/uncouple-last @["engine" "coal" "mail"])))

(t/deftest "2. uncoupling removes the car from the train"
  (def train @["engine" "coal" "mail"])
  (sol/uncouple-last train)
  (t/assert-equal @["engine" "coal"] train))

(t/deftest "2. nothing to uncouple from an empty train"
  (t/assert-equal nil (sol/uncouple-last @[])))

(t/deftest "3. the engine is at position 0"
  (t/assert-equal "engine" (sol/car-at @["engine" "coal" "mail"] 0)))

(t/deftest "3. a car in the middle"
  (t/assert-equal "coal" (sol/car-at @["engine" "coal" "mail"] 1)))

(t/deftest "3. a position beyond the end of the train"
  (t/assert-equal nil (sol/car-at @["engine" "coal" "mail"] 3)))

(t/deftest "4. insert a car in the middle"
  (t/assert-equal @["engine" "coal" "mail"] (sol/insert-car @["engine" "mail"] 1 "coal")))

(t/deftest "4. insert a car at the front"
  (t/assert-equal @["shunter" "engine"] (sol/insert-car @["engine"] 0 "shunter")))

(t/deftest "4. insert a car at the end"
  (t/assert-equal @["engine" "mail" "guard"] (sol/insert-car @["engine" "mail"] 2 "guard")))

(t/deftest "4. inserting changes the train itself"
  (def train @["engine" "mail"])
  (sol/insert-car train 1 "coal")
  (t/assert-equal @["engine" "coal" "mail"] train))

(t/deftest "5. the manifest lists the cars"
  (t/assert-equal ["engine" "coal" "mail"] (sol/manifest @["engine" "coal" "mail"])))

(t/deftest "5. the manifest is a tuple"
  (t/assert-true (tuple? (sol/manifest @["engine" "coal"]))))

(t/deftest "5. the manifest does not change when the train does"
  (def train @["engine" "coal"])
  (def written (sol/manifest train))
  (array/push train "mail")
  (t/assert-equal ["engine" "coal"] written))

(t/run)
