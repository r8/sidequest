(import test :as t)
(import ../high-scores :as sol)

(t/deftest "List of scores"
  (t/assert-equal [30 50 20 70] (sol/scores (sol/make-high-scores [30 50 20 70]))))

(t/deftest "Latest score"
  (t/assert-equal 30 (sol/latest (sol/make-high-scores [100 0 90 30]))))

(t/deftest "Personal best"
  (t/assert-equal 100 (sol/personal-best (sol/make-high-scores [40 100 70]))))

(t/deftest "Personal top three from a list of scores"
  (t/assert-equal [100 90 70] (sol/personal-top-three (sol/make-high-scores [10 30 90 30 100 20 10 0 30 40 40 70 70]))))

(t/deftest "Personal top highest to lowest"
  (t/assert-equal [30 20 10] (sol/personal-top-three (sol/make-high-scores [20 10 30]))))

(t/deftest "Personal top when there is a tie"
  (t/assert-equal [40 40 30] (sol/personal-top-three (sol/make-high-scores [40 20 40 30]))))

(t/deftest "Personal top when there are less than 3"
  (t/assert-equal [70 30] (sol/personal-top-three (sol/make-high-scores [30 70]))))

(t/deftest "Personal top when there is only one"
  (t/assert-equal [40] (sol/personal-top-three (sol/make-high-scores [40]))))

(t/deftest "Latest score after personal top scores"
  (def high-scores (sol/make-high-scores [70 50 20 30]))
  (sol/personal-top-three high-scores)
  (t/assert-equal 30 (sol/latest high-scores)))

(t/deftest "Scores after personal top scores"
  (def high-scores (sol/make-high-scores [30 50 20 70]))
  (sol/personal-top-three high-scores)
  (t/assert-equal [30 50 20 70] (sol/scores high-scores)))

(t/deftest "Latest score after personal best"
  (def high-scores (sol/make-high-scores [20 70 15 25 30]))
  (sol/personal-best high-scores)
  (t/assert-equal 30 (sol/latest high-scores)))

(t/deftest "Scores after personal best"
  (def high-scores (sol/make-high-scores [20 70 15 25 30]))
  (sol/personal-best high-scores)
  (t/assert-equal [20 70 15 25 30] (sol/scores high-scores)))

(t/run)
