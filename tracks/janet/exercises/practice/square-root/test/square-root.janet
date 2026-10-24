(import test :as t)
(import ../square-root :as sol)

(t/deftest "root of 1"
  (t/assert-equal 1 (sol/square-root 1)))

(t/deftest "root of 4"
  (t/assert-equal 2 (sol/square-root 4)))

(t/deftest "root of 25"
  (t/assert-equal 5 (sol/square-root 25)))

(t/deftest "root of 81"
  (t/assert-equal 9 (sol/square-root 81)))

(t/deftest "root of 196"
  (t/assert-equal 14 (sol/square-root 196)))

(t/deftest "root of 65025"
  (t/assert-equal 255 (sol/square-root 65025)))

(t/run)
