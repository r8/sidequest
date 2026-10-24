(import test :as t)
(import ../greet :as sol)

(t/deftest "no name"
  (t/assert-equal "Hello, you!" (sol/greet)))

(t/deftest "with a name"
  (t/assert-equal "Hello, Bob!" (sol/greet "Bob")))

(t/run)
