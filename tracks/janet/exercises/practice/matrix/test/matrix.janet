(import test :as t)
(import ../matrix :as sol)

(t/deftest "extract row from one number matrix"
  (t/assert-equal [1] (sol/row "1" 1)))

(t/deftest "can extract row"
  (t/assert-equal [3 4] (sol/row "1 2\n3 4" 2)))

(t/deftest "extract row where numbers have different widths"
  (t/assert-equal [10 20] (sol/row "1 2\n10 20" 2)))

(t/deftest "can extract row from non-square matrix with no corresponding column"
  (t/assert-equal [8 7 6] (sol/row "1 2 3\n4 5 6\n7 8 9\n8 7 6" 4)))

(t/deftest "extract column from one number matrix"
  (t/assert-equal [1] (sol/column "1" 1)))

(t/deftest "can extract column"
  (t/assert-equal [3 6 9] (sol/column "1 2 3\n4 5 6\n7 8 9" 3)))

(t/deftest "can extract column from non-square matrix with no corresponding row"
  (t/assert-equal [4 8 6] (sol/column "1 2 3 4\n5 6 7 8\n9 8 7 6" 4)))

(t/deftest "extract column where numbers have different widths"
  (t/assert-equal [1903 3 4] (sol/column "89 1903 3\n18 3 1\n9 4 800" 2)))

(t/run)
