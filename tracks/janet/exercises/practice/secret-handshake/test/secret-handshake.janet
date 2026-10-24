(import test :as t)
(import ../secret-handshake :as sol)

(t/deftest "wink for 1"
  (t/assert-equal [:wink] (sol/commands 1)))

(t/deftest "double blink for 10"
  (t/assert-equal [:double-blink] (sol/commands 2)))

(t/deftest "close your eyes for 100"
  (t/assert-equal [:close-your-eyes] (sol/commands 4)))

(t/deftest "jump for 1000"
  (t/assert-equal [:jump] (sol/commands 8)))

(t/deftest "combine two actions"
  (t/assert-equal [:wink :double-blink] (sol/commands 3)))

(t/deftest "reverse two actions"
  (t/assert-equal [:double-blink :wink] (sol/commands 19)))

(t/deftest "reversing one action gives the same action"
  (t/assert-equal [:jump] (sol/commands 24)))

(t/deftest "reversing no actions still gives no actions"
  (t/assert-equal [] (sol/commands 16)))

(t/deftest "all possible actions"
  (t/assert-equal [:wink :double-blink :close-your-eyes :jump] (sol/commands 15)))

(t/deftest "reverse all possible actions"
  (t/assert-equal [:jump :close-your-eyes :double-blink :wink] (sol/commands 31)))

(t/deftest "do nothing for zero"
  (t/assert-equal [] (sol/commands 0)))

(t/run)
