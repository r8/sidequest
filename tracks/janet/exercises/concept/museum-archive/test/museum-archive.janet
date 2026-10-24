(import test :as t)
(import ../museum-archive :as sol)

(t/deftest "1. two tables with the same contents"
  (t/assert-true (sol/same-record? @{:id 17 :notes @["bronze"]} @{:id 17 :notes @["bronze"]})))

(t/deftest "1. two tables with different notes"
  (t/assert-false (sol/same-record? @{:id 17 :notes @["bronze"]} @{:id 17 :notes @["iron"]})))

(t/deftest "1. two structs with the same contents"
  (t/assert-true (sol/same-record? {:id 3 :name "Urn" :notes ["clay" "roman"]} {:id 3 :name "Urn" :notes ["clay" "roman"]})))

(t/deftest "1. two structs with different numbers"
  (t/assert-false (sol/same-record? {:id 3 :name "Urn"} {:id 4 :name "Urn"})))

(t/deftest "2. a sealed record is a struct"
  (t/assert-equal :struct (type (sol/seal @{:id 17 :name @"Helmet" :notes @["bronze"]}))))

(t/deftest "2. sealing keeps the contents"
  (t/assert-true (= {:id 17 :name "Helmet" :notes ["bronze"]}
                    (sol/seal @{:id 17 :name @"Helmet" :notes @["bronze"]}))))

(t/deftest "2. nothing inside a sealed record is mutable"
  (def sealed (sol/seal @{:id 17 :name @"Helmet" :notes @["bronze" @"dented"]}))
  (t/assert-equal [:string :tuple :string] [(type (sealed :name)) (type (sealed :notes)) (type ((sealed :notes) 1))]))

(t/deftest "2. sealing leaves the original alone"
  (def record @{:id 17 :notes @["bronze"]})
  (sol/seal record)
  (array/push (record :notes) "dented")
  (t/assert-equal [:table :array 2] [(type record) (type (record :notes)) (length (record :notes))]))

(t/deftest "3. a reopened record is a table"
  (t/assert-equal :table (type (sol/reopen {:id 17 :name "Helmet" :notes ["bronze"]}))))

(t/deftest "3. reopening keeps the contents"
  (t/assert-true (deep= @{:id 17 :name @"Helmet" :notes @[@"bronze"]}
                        (sol/reopen {:id 17 :name "Helmet" :notes ["bronze"]}))))

(t/deftest "3. everything inside a reopened record is mutable"
  (def record (sol/reopen {:id 17 :name "Helmet" :notes ["bronze"]}))
  (array/push (record :notes) "dented")
  (buffer/push (record :name) "!")
  (put record :room 4)
  (t/assert-equal @{:id 17 :name @"Helmet!" :notes @["bronze" "dented"] :room 4} record))

(t/deftest "4. the copy holds the same names"
  (t/assert-equal @["Ada" "Bo"] (sol/copy-log @["Ada" "Bo"])))

(t/deftest "4. the copy is a different array"
  (def log @["Ada" "Bo"])
  (t/assert-false (= log (sol/copy-log log))))

(t/deftest "4. adding to the copy leaves the log alone"
  (def log @["Ada" "Bo"])
  (def copy (sol/copy-log log))
  (array/push copy "Cy")
  (t/assert-equal [@["Ada" "Bo"] @["Ada" "Bo" "Cy"]] [log copy]))

(t/deftest "5. add a note to a record with notes"
  (t/assert-true (= {:id 17 :notes ["bronze" "dented"]} (sol/add-note {:id 17 :notes ["bronze"]} "dented"))))

(t/deftest "5. add a note to a record without notes"
  (t/assert-true (= {:id 3 :name "Urn" :notes ["clay"]} (sol/add-note {:id 3 :name "Urn"} "clay"))))

(t/deftest "5. adding a note leaves the original alone"
  (def record {:id 17 :notes ["bronze"]})
  (sol/add-note record "dented")
  (t/assert-true (= {:id 17 :notes ["bronze"]} record)))

(t/run)
