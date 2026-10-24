(import test :as t)
(import ../yacht :as sol)

(t/deftest "Yacht"
  (t/assert-equal 50 (sol/score [5 5 5 5 5] :yacht)))

(t/deftest "Not Yacht"
  (t/assert-equal 0 (sol/score [1 3 3 2 5] :yacht)))

(t/deftest "Ones"
  (t/assert-equal 3 (sol/score [1 1 1 3 5] :ones)))

(t/deftest "Ones, out of order"
  (t/assert-equal 3 (sol/score [3 1 1 5 1] :ones)))

(t/deftest "No ones"
  (t/assert-equal 0 (sol/score [4 3 6 5 5] :ones)))

(t/deftest "Twos"
  (t/assert-equal 2 (sol/score [2 3 4 5 6] :twos)))

(t/deftest "Fours"
  (t/assert-equal 8 (sol/score [1 4 1 4 1] :fours)))

(t/deftest "Yacht counted as threes"
  (t/assert-equal 15 (sol/score [3 3 3 3 3] :threes)))

(t/deftest "Yacht of 3s counted as fives"
  (t/assert-equal 0 (sol/score [3 3 3 3 3] :fives)))

(t/deftest "Fives"
  (t/assert-equal 10 (sol/score [1 5 3 5 3] :fives)))

(t/deftest "Sixes"
  (t/assert-equal 6 (sol/score [2 3 4 5 6] :sixes)))

(t/deftest "Full house two small, three big"
  (t/assert-equal 16 (sol/score [2 2 4 4 4] :full-house)))

(t/deftest "Full house three small, two big"
  (t/assert-equal 19 (sol/score [5 3 3 5 3] :full-house)))

(t/deftest "Two pair is not a full house"
  (t/assert-equal 0 (sol/score [2 2 4 4 5] :full-house)))

(t/deftest "Four of a kind is not a full house"
  (t/assert-equal 0 (sol/score [1 4 4 4 4] :full-house)))

(t/deftest "Yacht is not a full house"
  (t/assert-equal 0 (sol/score [2 2 2 2 2] :full-house)))

(t/deftest "Four of a Kind"
  (t/assert-equal 24 (sol/score [6 6 4 6 6] :four-of-a-kind)))

(t/deftest "Yacht can be scored as Four of a Kind"
  (t/assert-equal 12 (sol/score [3 3 3 3 3] :four-of-a-kind)))

(t/deftest "Full house is not Four of a Kind"
  (t/assert-equal 0 (sol/score [3 3 3 5 5] :four-of-a-kind)))

(t/deftest "Little Straight"
  (t/assert-equal 30 (sol/score [3 5 4 1 2] :little-straight)))

(t/deftest "Little Straight as Big Straight"
  (t/assert-equal 0 (sol/score [1 2 3 4 5] :big-straight)))

(t/deftest "Four in order but not a little straight"
  (t/assert-equal 0 (sol/score [1 1 2 3 4] :little-straight)))

(t/deftest "No pairs but not a little straight"
  (t/assert-equal 0 (sol/score [1 2 3 4 6] :little-straight)))

(t/deftest "Minimum is 1, maximum is 5, but not a little straight"
  (t/assert-equal 0 (sol/score [1 1 3 4 5] :little-straight)))

(t/deftest "Big Straight"
  (t/assert-equal 30 (sol/score [4 6 2 5 3] :big-straight)))

(t/deftest "Big Straight as little straight"
  (t/assert-equal 0 (sol/score [6 5 4 3 2] :little-straight)))

(t/deftest "No pairs but not a big straight"
  (t/assert-equal 0 (sol/score [6 5 4 3 1] :big-straight)))

(t/deftest "Choice"
  (t/assert-equal 23 (sol/score [3 3 5 6 6] :choice)))

(t/deftest "Yacht as choice"
  (t/assert-equal 10 (sol/score [2 2 2 2 2] :choice)))

(t/run)
