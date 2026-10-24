(import test :as t)
(import ../greet :as sol)

(t/deftest "passes"
  (t/assert-equal "Hello, you!" (sol/greet)))

(t/deftest "fails on a table"
  (t/assert-equal {:a [1 2]} @{:a @[1 3]}))

(t/deftest "fails on a missing error"
  (t/assert-error "boom" (sol/greet)))

(t/run)
