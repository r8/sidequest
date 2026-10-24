(import test :as t)
(import ../two-fer :as sol)

(t/deftest "no name given"
  (t/assert-equal "One for you, one for me." (sol/two-fer)))

(t/deftest "a name given"
  (t/assert-equal "One for Alice, one for me." (sol/two-fer "Alice")))

(t/deftest "another name given"
  (t/assert-equal "One for Bob, one for me." (sol/two-fer "Bob")))

(t/run)
