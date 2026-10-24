(import test :as t)
(import ../binary-search-tree :as sol)

(t/deftest "data is retained"
  (t/assert-equal
    {:data 4 :left nil :right nil}
    (sol/make-tree [4])))

(t/deftest "smaller number at left node"
  (t/assert-equal
    {:data 4 :left {:data 2 :left nil :right nil} :right nil}
    (sol/make-tree [4 2])))

(t/deftest "same number at left node"
  (t/assert-equal
    {:data 4 :left {:data 4 :left nil :right nil} :right nil}
    (sol/make-tree [4 4])))

(t/deftest "greater number at right node"
  (t/assert-equal
    {:data 4 :left nil :right {:data 5 :left nil :right nil}}
    (sol/make-tree [4 5])))

(t/deftest "can create complex tree"
  (t/assert-equal
    {:data 4 :left {:data 2 :left {:data 1 :left nil :right nil} :right {:data 3 :left nil :right nil}} :right {:data 6 :left {:data 5 :left nil :right nil} :right {:data 7 :left nil :right nil}}}
    (sol/make-tree [4 2 6 1 3 5 7])))

(t/deftest "can sort single number"
  (t/assert-equal [2] (sol/sorted-data (sol/make-tree [2]))))

(t/deftest "can sort if second number is smaller than first"
  (t/assert-equal [1 2] (sol/sorted-data (sol/make-tree [2 1]))))

(t/deftest "can sort if second number is same as first"
  (t/assert-equal [2 2] (sol/sorted-data (sol/make-tree [2 2]))))

(t/deftest "can sort if second number is greater than first"
  (t/assert-equal [2 3] (sol/sorted-data (sol/make-tree [2 3]))))

(t/deftest "can sort complex tree"
  (t/assert-equal [1 2 3 5 6 7] (sol/sorted-data (sol/make-tree [2 1 3 6 7 5]))))

(t/run)
