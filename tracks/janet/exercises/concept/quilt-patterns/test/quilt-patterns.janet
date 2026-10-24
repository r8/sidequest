(import test :as t)
(import ../quilt-patterns :as sol)

(t/deftest "1. a single patch is light"
  (t/assert-equal [[:light]] (sol/checkerboard 1 1)))

(t/deftest "1. two rows of three"
  (t/assert-equal [[:light :dark :light]
                   [:dark :light :dark]]
                  (sol/checkerboard 2 3)))

(t/deftest "1. a square of four"
  (t/assert-equal [[:light :dark :light :dark]
                   [:dark :light :dark :light]
                   [:light :dark :light :dark]
                   [:dark :light :dark :light]]
                  (sol/checkerboard 4 4)))

(t/deftest "1. no rows at all"
  (t/assert-equal [] (sol/checkerboard 0 3)))

(t/deftest "2. every patch of a 2 by 2 quilt is on the border"
  (t/assert-equal [[0 0] [0 1] [1 0] [1 1]] (sol/border-patches 2 2)))

(t/deftest "2. the middle of a 3 by 3 quilt is not"
  (t/assert-equal [[0 0] [0 1] [0 2] [1 0] [1 2] [2 0] [2 1] [2 2]] (sol/border-patches 3 3)))

(t/deftest "2. a 3 by 4 quilt"
  (t/assert-equal [[0 0] [0 1] [0 2] [0 3] [1 0] [1 3] [2 0] [2 1] [2 2] [2 3]] (sol/border-patches 3 4)))

(t/deftest "2. a single row is all border"
  (t/assert-equal [[0 0] [0 1] [0 2]] (sol/border-patches 1 3)))

(t/deftest "3. one colour"
  (t/assert-equal @{:red 4} (sol/fabric-needed @[@[:red :red] @[:red :red]])))

(t/deftest "3. two colours"
  (t/assert-equal @{:red 1 :cream 3} (sol/fabric-needed @[@[:red :cream] @[:cream :cream]])))

(t/deftest "3. rows of different lengths"
  (t/assert-equal @{:navy 2 :red 1 :gold 3} (sol/fabric-needed @[@[:navy] @[:gold :red :gold] @[:gold :navy]])))

(t/deftest "3. an empty quilt"
  (t/assert-equal @{} (sol/fabric-needed @[])))

(t/deftest "4. three colours"
  (t/assert-equal @{:red 0 :cream 1 :navy 2} (sol/palette-index [:red :cream :navy])))

(t/deftest "4. a single colour"
  (t/assert-equal @{:gold 0} (sol/palette-index [:gold])))

(t/deftest "4. an empty palette"
  (t/assert-equal @{} (sol/palette-index [])))

(t/deftest "5. a strip three times"
  (t/assert-equal [:red :navy :red :navy :red :navy] (sol/repeat-strip [:red :navy] 3)))

(t/deftest "5. a strip once"
  (t/assert-equal [:gold :cream :gold] (sol/repeat-strip [:gold :cream :gold] 1)))

(t/deftest "5. a strip no times"
  (t/assert-equal [] (sol/repeat-strip [:red] 0)))

(t/run)
