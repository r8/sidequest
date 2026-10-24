(import test :as t)
(import ../saddle-points :as sol)

# Saddle points may come back in any order.
(defn- sorted [points]
  (sort-by (fn [p] [(p :row) (p :column)]) (array ;points)))

(t/deftest "Can identify single saddle point"
  (t/assert-equal [{:row 2 :column 1}] (sorted (sol/saddle-points [[9 8 7] [5 3 2] [6 6 7]]))))

(t/deftest "Can identify that empty matrix has no saddle points"
  (t/assert-equal [] (sorted (sol/saddle-points [[]]))))

(t/deftest "Can identify lack of saddle points when there are none"
  (t/assert-equal [] (sorted (sol/saddle-points [[1 2 3] [3 1 2] [2 3 1]]))))

(t/deftest "Can identify multiple saddle points in a column"
  (t/assert-equal [{:row 1 :column 2} {:row 2 :column 2} {:row 3 :column 2}] (sorted (sol/saddle-points [[4 5 4] [3 5 5] [1 5 4]]))))

(t/deftest "Can identify multiple saddle points in a row"
  (t/assert-equal [{:row 2 :column 1} {:row 2 :column 2} {:row 2 :column 3}] (sorted (sol/saddle-points [[6 7 8] [5 5 5] [7 5 6]]))))

(t/deftest "Can identify saddle point in bottom right corner"
  (t/assert-equal [{:row 3 :column 3}] (sorted (sol/saddle-points [[8 7 9] [6 7 6] [3 2 5]]))))

(t/deftest "Can identify saddle points in a non square matrix"
  (t/assert-equal [{:row 1 :column 1} {:row 1 :column 3}] (sorted (sol/saddle-points [[3 1 3] [3 2 4]]))))

(t/deftest "Can identify that saddle points in a single column matrix are those with the minimum value"
  (t/assert-equal [{:row 2 :column 1} {:row 4 :column 1}] (sorted (sol/saddle-points [[2] [1] [4] [1]]))))

(t/deftest "Can identify that saddle points in a single row matrix are those with the maximum value"
  (t/assert-equal [{:row 1 :column 2} {:row 1 :column 4}] (sorted (sol/saddle-points [[2 5 3 5]]))))

(t/run)
