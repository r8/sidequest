(import test :as t)
(import ../star-charts :as sol)

(def vega {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [4 7]})
(def sirius {:name "Sirius" :constellation "Canis Major" :magnitude -1.46 :position [2 2]})
(def deneb {:name "Deneb" :constellation "Cygnus" :magnitude 1.25 :position [9 -3]})
(def altair {:name "Altair" :constellation "Aquila" :magnitude 0.76 :position [-5 0]})

(t/deftest "1. distance between two points"
  (t/assert-equal 5 (sol/distance [1 1] [4 5])))

(t/deftest "1. distance from a point to itself"
  (t/assert-equal 0 (sol/distance [3 3] [3 3])))

(t/deftest "1. distance across the centre"
  (t/assert-equal 10 (sol/distance [-3 -4] [3 4])))

(t/deftest "1. distance along one axis"
  (t/assert-equal 7 (sol/distance [2 -1] [2 6])))

(t/deftest "2. label Vega"
  (t/assert-equal "Vega in Lyra" (sol/label vega)))

(t/deftest "2. label Sirius"
  (t/assert-equal "Sirius in Canis Major" (sol/label sirius)))

(t/deftest "2. label a star given as a table"
  (t/assert-equal "Mira in Cetus" (sol/label @{:name "Mira" :constellation "Cetus" :magnitude 3 :position [0 1]})))

(t/deftest "3. headline for two stars"
  (t/assert-equal {:brightest "Sirius" :others 1} (sol/headline [sirius vega])))

(t/deftest "3. headline for four stars"
  (t/assert-equal {:brightest "Sirius" :others 3} (sol/headline [sirius vega altair deneb])))

(t/deftest "3. headline for a single star"
  (t/assert-equal {:brightest "Deneb" :others 0} (sol/headline [deneb])))

(t/deftest "4. shift Vega"
  (t/assert-equal {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [5 5]} (sol/shift vega 1 -2)))

(t/deftest "4. shift Altair across the centre"
  (t/assert-equal {:name "Altair" :constellation "Aquila" :magnitude 0.76 :position [3 4]} (sol/shift altair 8 4)))

(t/deftest "4. the shifted star is a new struct"
  (sol/shift vega 1 1)
  (t/assert-equal [4 7] (vega :position)))

(t/deftest "5. flip two positions"
  (t/assert-equal @[[4 -7] [2 2]] (sol/flip [[4 7] [2 -2]])))

(t/deftest "5. a position on the axis stays put"
  (t/assert-equal @[[-5 0]] (sol/flip [[-5 0]])))

(t/deftest "5. flip no positions"
  (t/assert-equal @[] (sol/flip [])))

(t/run)
