(import test :as t)
(import ../spice-rack :as sol)

(t/deftest "1. a spice from a single grower"
  (t/assert-equal "Iran" (sol/origin :saffron)))

(t/deftest "1. another spice from a single grower"
  (t/assert-equal "Hungary" (sol/origin :paprika)))

(t/deftest "1. a spice without a known origin"
  (t/assert-equal "unknown" (sol/origin :salt)))

(t/deftest "2. grams of a spice in the rack"
  (t/assert-equal 80 (sol/grams-of @{:cumin 80 :clove 15} :cumin)))

(t/deftest "2. grams of a spice missing from the rack"
  (t/assert-equal 0 (sol/grams-of @{:cumin 80 :clove 15} :mace)))

(t/deftest "2. grams of a spice in an empty rack"
  (t/assert-equal 0 (sol/grams-of @{} :cumin)))

(t/deftest "3. restock a spice already in the rack"
  (t/assert-equal @{:cumin 130} (sol/restock @{:cumin 80} :cumin 50)))

(t/deftest "3. restock a new spice"
  (t/assert-equal @{:cumin 80 :clove 25} (sol/restock @{:cumin 80} :clove 25)))

(t/deftest "3. restocking changes the rack itself"
  (def rack @{:cumin 80})
  (sol/restock rack :mace 10)
  (t/assert-equal @{:cumin 80 :mace 10} rack))

(t/deftest "4. use some of a spice"
  (t/assert-equal @{:cumin 50 :clove 15} (sol/use-spice @{:cumin 80 :clove 15} :cumin 30)))

(t/deftest "4. use the last of a spice"
  (t/assert-equal @{:cumin 80} (sol/use-spice @{:cumin 80 :clove 15} :clove 15)))

(t/deftest "4. use more than is left"
  (t/assert-equal @{:clove 15} (sol/use-spice @{:cumin 80 :clove 15} :cumin 100)))

(t/deftest "4. using a spice changes the rack itself"
  (def rack @{:cumin 80})
  (sol/use-spice rack :cumin 20)
  (t/assert-equal @{:cumin 60} rack))

(t/deftest "5. spices below the limit"
  (t/assert-equal @{:clove 15 :sumac 30} (sol/low-stock @{:cumin 80 :clove 15 :sumac 30} 50)))

(t/deftest "5. a spice at the limit is not low"
  (t/assert-equal @{} (sol/low-stock @{:cumin 50 :clove 60} 50)))

(t/deftest "5. the rack does not change"
  (def rack @{:cumin 80 :clove 15})
  (sol/low-stock rack 50)
  (t/assert-equal @{:cumin 80 :clove 15} rack))

(t/run)
