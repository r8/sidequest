(import test :as t)
(import ../greet :as sol)

(t/deftest "never run, because the file does not call (t/run)"
  (t/assert-equal "Hello, you!" (sol/greet)))
