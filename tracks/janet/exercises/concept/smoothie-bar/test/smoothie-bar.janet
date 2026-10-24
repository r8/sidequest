(import test :as t)
(import ../smoothie-bar :as sol)

(def prices {"mango" 3 "kiwi" 2 "banana" 1 "pineapple" 4})

(t/deftest "1. trims the surrounding whitespace"
  (t/assert-equal "mango" (sol/clean-name "  mango ")))

(t/deftest "1. lower-cases the name"
  (t/assert-equal "kiwi" (sol/clean-name "KiWi")))

(t/deftest "1. trims and lower-cases together"
  (t/assert-equal "passion fruit" (sol/clean-name "\tPassion Fruit  ")))

(t/deftest "1. an empty name stays empty"
  (t/assert-equal "" (sol/clean-name "   ")))

(t/deftest "2. a single ingredient"
  (t/assert-equal ["banana"] (sol/ingredients "banana")))

(t/deftest "2. several ingredients, cleaned"
  (t/assert-equal ["mango" "banana" "kiwi"] (sol/ingredients " Mango, banana ,KIWI")))

(t/deftest "2. empty entries are skipped"
  (t/assert-equal ["mango" "kiwi"] (sol/ingredients "mango,, ,kiwi,")))

(t/deftest "2. an empty order"
  (t/assert-equal [] (sol/ingredients "")))

(t/deftest "3. one ingredient"
  (t/assert-equal 4 (sol/blend-price "pineapple" prices)))

(t/deftest "3. several ingredients"
  (t/assert-equal 5 (sol/blend-price "mango, kiwi" prices)))

(t/deftest "3. a messy order"
  (t/assert-equal 7 (sol/blend-price " BANANA,,mango , kiwi, banana" prices)))

(t/deftest "4. a regular with stamps"
  (t/assert-equal 2 (sol/free-smoothies @{"Lou" {:stamps 23}} "Lou")))

(t/deftest "4. not enough stamps yet"
  (t/assert-equal 0 (sol/free-smoothies @{"Lou" {:stamps 9} "Ana" {:stamps 40}} "Lou")))

(t/deftest "4. an unknown customer"
  (t/assert-equal nil (sol/free-smoothies @{"Lou" {:stamps 23}} "Ana")))

(t/deftest "4. a customer without stamps"
  (t/assert-equal nil (sol/free-smoothies @{"Lou" {:email "lou@example.com"}} "Lou")))

(t/deftest "5. a receipt for two ingredients"
  (t/assert-equal "mango + kiwi = 5" (sol/receipt " Mango,KIWI" prices)))

(t/deftest "5. a receipt for one ingredient"
  (t/assert-equal "banana = 1" (sol/receipt "banana" prices)))

(t/deftest "5. a receipt for a messy order"
  (t/assert-equal "pineapple + banana + banana = 6" (sol/receipt "Pineapple,, banana,BANANA" prices)))

(t/run)
