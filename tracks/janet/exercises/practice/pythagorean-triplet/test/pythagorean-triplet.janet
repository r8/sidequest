(import test :as t)
(import ../pythagorean-triplet :as sol)

(t/deftest "triplets whose sum is 12"
  (t/assert-equal [[3 4 5]] (sol/triplets-with-sum 12)))

(t/deftest "triplets whose sum is 108"
  (t/assert-equal [[27 36 45]] (sol/triplets-with-sum 108)))

(t/deftest "triplets whose sum is 1000"
  (t/assert-equal [[200 375 425]] (sol/triplets-with-sum 1000)))

(t/deftest "no matching triplets for 1001"
  (t/assert-equal [] (sol/triplets-with-sum 1001)))

(t/deftest "returns all matching triplets"
  (t/assert-equal [[9 40 41] [15 36 39]] (sol/triplets-with-sum 90)))

(t/deftest "several matching triplets"
  (t/assert-equal [[40 399 401] [56 390 394] [105 360 375] [120 350 370] [140 336 364] [168 315 357] [210 280 350] [240 252 348]] (sol/triplets-with-sum 840)))

(t/deftest "triplets for large number"
  (t/assert-equal [[1200 14375 14425] [1875 14000 14125] [5000 12000 13000] [6000 11250 12750] [7500 10000 12500]] (sol/triplets-with-sum 30000)))

(t/run)
