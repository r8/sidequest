(import test :as t)
(import ../linked-list :as sol)

(t/deftest "pop gets element from the list"
  (def list (sol/make-list))
  (sol/push list 7)
  (t/assert-equal 7 (sol/pop list)))

(t/deftest "push/pop respectively add/remove at the end of the list"
  (def list (sol/make-list))
  (sol/push list 11)
  (sol/push list 13)
  (t/assert-equal 13 (sol/pop list))
  (t/assert-equal 11 (sol/pop list)))

(t/deftest "shift gets an element from the list"
  (def list (sol/make-list))
  (sol/push list 17)
  (t/assert-equal 17 (sol/shift list)))

(t/deftest "shift gets first element from the list"
  (def list (sol/make-list))
  (sol/push list 23)
  (sol/push list 5)
  (t/assert-equal 23 (sol/shift list))
  (t/assert-equal 5 (sol/shift list)))

(t/deftest "unshift adds element at start of the list"
  (def list (sol/make-list))
  (sol/unshift list 23)
  (sol/unshift list 5)
  (t/assert-equal 5 (sol/shift list))
  (t/assert-equal 23 (sol/shift list)))

(t/deftest "pop, push, shift, and unshift can be used in any order"
  (def list (sol/make-list))
  (sol/push list 1)
  (sol/push list 2)
  (t/assert-equal 2 (sol/pop list))
  (sol/push list 3)
  (t/assert-equal 1 (sol/shift list))
  (sol/unshift list 4)
  (sol/push list 5)
  (t/assert-equal 4 (sol/shift list))
  (t/assert-equal 5 (sol/pop list))
  (t/assert-equal 3 (sol/shift list)))

(t/deftest "count an empty list"
  (def list (sol/make-list))
  (t/assert-equal 0 (sol/size list)))

(t/deftest "count a list with items"
  (def list (sol/make-list))
  (sol/push list 37)
  (sol/push list 1)
  (t/assert-equal 2 (sol/size list)))

(t/deftest "count is correct after mutation"
  (def list (sol/make-list))
  (sol/push list 31)
  (t/assert-equal 1 (sol/size list))
  (sol/unshift list 43)
  (t/assert-equal 2 (sol/size list))
  (sol/shift list)
  (t/assert-equal 1 (sol/size list))
  (sol/pop list)
  (t/assert-equal 0 (sol/size list)))

(t/deftest "popping to empty doesn't break the list"
  (def list (sol/make-list))
  (sol/push list 41)
  (sol/push list 59)
  (sol/pop list)
  (sol/pop list)
  (sol/push list 47)
  (t/assert-equal 1 (sol/size list))
  (t/assert-equal 47 (sol/pop list)))

(t/deftest "shifting to empty doesn't break the list"
  (def list (sol/make-list))
  (sol/push list 41)
  (sol/push list 59)
  (sol/shift list)
  (sol/shift list)
  (sol/push list 47)
  (t/assert-equal 1 (sol/size list))
  (t/assert-equal 47 (sol/shift list)))

(t/deftest "deletes the only element"
  (def list (sol/make-list))
  (sol/push list 61)
  (sol/delete list 61)
  (t/assert-equal 0 (sol/size list)))

(t/deftest "deletes the element with the specified value from the list"
  (def list (sol/make-list))
  (sol/push list 71)
  (sol/push list 83)
  (sol/push list 79)
  (sol/delete list 83)
  (t/assert-equal 2 (sol/size list))
  (t/assert-equal 79 (sol/pop list))
  (t/assert-equal 71 (sol/shift list)))

(t/deftest "deletes the element with the specified value from the list, re-assigns tail"
  (def list (sol/make-list))
  (sol/push list 71)
  (sol/push list 83)
  (sol/push list 79)
  (sol/delete list 83)
  (t/assert-equal 2 (sol/size list))
  (t/assert-equal 79 (sol/pop list))
  (t/assert-equal 71 (sol/pop list)))

(t/deftest "deletes the element with the specified value from the list, re-assigns head"
  (def list (sol/make-list))
  (sol/push list 71)
  (sol/push list 83)
  (sol/push list 79)
  (sol/delete list 83)
  (t/assert-equal 2 (sol/size list))
  (t/assert-equal 71 (sol/shift list))
  (t/assert-equal 79 (sol/shift list)))

(t/deftest "deletes the first of two elements"
  (def list (sol/make-list))
  (sol/push list 97)
  (sol/push list 101)
  (sol/delete list 97)
  (t/assert-equal 1 (sol/size list))
  (t/assert-equal 101 (sol/pop list)))

(t/deftest "deletes the second of two elements"
  (def list (sol/make-list))
  (sol/push list 97)
  (sol/push list 101)
  (sol/delete list 101)
  (t/assert-equal 1 (sol/size list))
  (t/assert-equal 97 (sol/pop list)))

(t/deftest "delete does not modify the list if the element is not found"
  (def list (sol/make-list))
  (sol/push list 89)
  (sol/delete list 103)
  (t/assert-equal 1 (sol/size list)))

(t/deftest "deletes only the first occurrence"
  (def list (sol/make-list))
  (sol/push list 73)
  (sol/push list 9)
  (sol/push list 9)
  (sol/push list 107)
  (sol/delete list 9)
  (t/assert-equal 3 (sol/size list))
  (t/assert-equal 107 (sol/pop list))
  (t/assert-equal 9 (sol/pop list))
  (t/assert-equal 73 (sol/pop list)))

(t/run)
