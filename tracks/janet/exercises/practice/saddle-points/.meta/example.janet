# A saddle point is a struct {:row row :column column}; rows and columns are numbered from 1.

(defn saddle-points
  "(saddle-points matrix) -> the saddle points of matrix, a tuple of rows, in any order"
  [matrix]
  (seq [[r row] :pairs matrix
        [c x] :pairs row
        :when (= x (max ;row))
        :when (= x (min ;(map |($ c) matrix)))]
    {:row (inc r) :column (inc c)}))
