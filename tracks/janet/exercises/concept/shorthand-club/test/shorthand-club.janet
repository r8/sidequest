(import test :as t)
(import ../shorthand-club :as sol)

# The macros are expanded when each test runs, with eval and macex1, so that a test file
# using an unfinished macro still loads.

(t/deftest "1. the expansion runs the form twice"
  (t/assert-true (deep= '(do (print "hip hip") (print "hip hip")) (macex1 '(sol/twice (print "hip hip"))))))

(t/deftest "1. the form really runs twice"
  (t/assert-equal 2 (eval '(do (var n 0) (sol/twice (++ n)) n))))

(t/deftest "1. the value of the second run"
  (t/assert-equal 20 (eval '(do (var n 0) (sol/twice (+= n 10))))))

(t/deftest "2. a positive number runs the body"
  (t/assert-equal :yes (eval '(sol/when-positive 3 :ignored :yes))))

(t/deftest "2. zero does not"
  (t/assert-equal nil (eval '(sol/when-positive 0 :yes))))

(t/deftest "2. the body does not run for a negative number"
  (t/assert-equal 0 (eval '(do (var n 0) (sol/when-positive -5 (++ n)) n))))

(t/deftest "2. the number can be any expression"
  (t/assert-equal "big" (eval '(sol/when-positive (- 10 3) "big"))))

(t/deftest "3. a sum and its value"
  (def [form value] (eval '(sol/show (+ 1 2))))
  (t/assert-true (deep= '(+ 1 2) form))
  (t/assert-equal 3 value))

(t/deftest "3. a string's form is the string"
  (t/assert-equal ["shorthand" "shorthand"] (eval '(sol/show "shorthand"))))

(t/deftest "3. a symbol stays a symbol"
  (t/assert-equal ['math/pi math/pi] (eval '(sol/show math/pi))))

(t/deftest "4. a shorthand for a function"
  (t/assert-equal "shorthand" (eval '(do (sol/defshort str string) (str "short" "hand")))))

(t/deftest "4. a shorthand for a value"
  (t/assert-equal 42 (eval '(do (sol/defshort answer (* 6 7)) answer))))

(t/deftest "4. the expansion is a def"
  (t/assert-true (deep= '(def x 1) (macex1 '(sol/defshort x 1)))))

(t/deftest "5. squaring a number"
  (t/assert-equal 9 (eval '(sol/square 3))))

(t/deftest "5. squaring an expression"
  (t/assert-equal 49 (eval '(sol/square (+ 3 4)))))

(t/deftest "5. the expression is evaluated once"
  (t/assert-equal 1 (eval '(do (var n 0) (sol/square (do (++ n) 3)) n))))

(t/deftest "5. the caller's names are safe"
  (t/assert-equal [25 36 16]
                  (eval '(do (def tmp 5) (def value 6) (def x 4)
                             [(sol/square tmp) (sol/square value) (sol/square x)]))))

(t/run)
