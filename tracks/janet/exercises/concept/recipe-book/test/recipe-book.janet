(import test :as t)
(import ../units :as units)
(import ../recipe-book :as sol)

(def bread [["flour" 1 :kg] ["water" 700 :g] ["salt" 20 :g]])
(def cake [["butter" 8 :oz] ["sugar" 1 :lb] ["flour" 250 :g]])

(t/deftest "1. grams stay grams"
  (t/assert-equal 250 (units/to-grams 250 :g)))

(t/deftest "1. kilograms, ounces and pounds"
  (t/assert-equal [1500 224 908] [(units/to-grams 1.5 :kg) (units/to-grams 8 :oz) (units/to-grams 2 :lb)]))

(t/deftest "1. the conversion table is private"
  (t/assert-equal nil (in (curenv) 'units/grams-per)))

(t/deftest "2. less than a kilogram in grams"
  (t/assert-equal "250 g" (units/format-grams 250)))

(t/deftest "2. a whole kilogram"
  (t/assert-equal "1 kg" (units/format-grams 1000)))

(t/deftest "2. more than a kilogram"
  (t/assert-equal "1.5 kg" (units/format-grams 1500)))

(t/deftest "3. a recipe in grams"
  (t/assert-equal @{"flour" 1000 "water" 700 "salt" 20} (sol/in-grams bread)))

(t/deftest "3. a recipe in imperial units"
  (t/assert-equal @{"butter" 224 "sugar" 454 "flour" 250} (sol/in-grams cake)))

(t/deftest "3. an empty recipe"
  (t/assert-equal @{} (sol/in-grams [])))

(t/deftest "4. the shopping list for one loaf"
  (t/assert-equal ["flour: 1 kg" "water: 700 g" "salt: 20 g"] (sol/shopping-list bread 1)))

(t/deftest "4. the shopping list for three loaves"
  (t/assert-equal ["flour: 3 kg" "water: 2.1 kg" "salt: 60 g"] (sol/shopping-list bread 3)))

(t/deftest "4. the shopping list for half a cake"
  (t/assert-equal ["butter: 112 g" "sugar: 227 g" "flour: 125 g"] (sol/shopping-list cake 0.5)))

(t/deftest "5. the weight of a loaf"
  (t/assert-equal "1.72 kg" (sol/total-weight bread)))

(t/deftest "5. the weight of a cake"
  (t/assert-equal "928 g" (sol/total-weight cake)))

(t/deftest "5. the weight of nothing"
  (t/assert-equal "0 g" (sol/total-weight [])))

(t/run)
