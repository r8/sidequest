(import test :as t)
(import ../greet :as sol)

(t/deftest "stub raises"
  (t/assert-equal "Hello, you!" (sol/greet)))

(t/deftest "arrays compare by content"
  (t/assert-equal [1 2 3] @[1 2 3]))

(t/run)
