(import test :as t)
(import ../wordy :as sol)

(t/deftest "just a number"
  (t/assert-equal 5 (sol/answer "What is 5?")))

(t/deftest "just a zero"
  (t/assert-equal 0 (sol/answer "What is 0?")))

(t/deftest "just a negative number"
  (t/assert-equal -123 (sol/answer "What is -123?")))

(t/deftest "addition"
  (t/assert-equal 2 (sol/answer "What is 1 plus 1?")))

(t/deftest "addition with a left hand zero"
  (t/assert-equal 2 (sol/answer "What is 0 plus 2?")))

(t/deftest "addition with a right hand zero"
  (t/assert-equal 3 (sol/answer "What is 3 plus 0?")))

(t/deftest "more addition"
  (t/assert-equal 55 (sol/answer "What is 53 plus 2?")))

(t/deftest "addition with negative numbers"
  (t/assert-equal -11 (sol/answer "What is -1 plus -10?")))

(t/deftest "large addition"
  (t/assert-equal 45801 (sol/answer "What is 123 plus 45678?")))

(t/deftest "subtraction"
  (t/assert-equal 16 (sol/answer "What is 4 minus -12?")))

(t/deftest "multiplication"
  (t/assert-equal -75 (sol/answer "What is -3 multiplied by 25?")))

(t/deftest "division"
  (t/assert-equal -11 (sol/answer "What is 33 divided by -3?")))

(t/deftest "multiple additions"
  (t/assert-equal 3 (sol/answer "What is 1 plus 1 plus 1?")))

(t/deftest "addition and subtraction"
  (t/assert-equal 8 (sol/answer "What is 1 plus 5 minus -2?")))

(t/deftest "multiple subtraction"
  (t/assert-equal 3 (sol/answer "What is 20 minus 4 minus 13?")))

(t/deftest "subtraction then addition"
  (t/assert-equal 14 (sol/answer "What is 17 minus 6 plus 3?")))

(t/deftest "multiple multiplication"
  (t/assert-equal -12 (sol/answer "What is 2 multiplied by -2 multiplied by 3?")))

(t/deftest "addition and multiplication"
  (t/assert-equal -8 (sol/answer "What is -3 plus 7 multiplied by -2?")))

(t/deftest "multiple division"
  (t/assert-equal 2 (sol/answer "What is -12 divided by 2 divided by -3?")))

(t/deftest "unknown operation"
  (t/assert-error "unknown operation" (sol/answer "What is 52 cubed?")))

(t/deftest "Non math question"
  (t/assert-error "unknown operation" (sol/answer "Who is the President of the United States?")))

(t/deftest "reject problem missing an operand"
  (t/assert-error "syntax error" (sol/answer "What is 1 plus?")))

(t/deftest "reject problem with no operands or operators"
  (t/assert-error "syntax error" (sol/answer "What is?")))

(t/deftest "reject two operations in a row"
  (t/assert-error "syntax error" (sol/answer "What is 1 plus plus 2?")))

(t/deftest "reject two numbers in a row"
  (t/assert-error "syntax error" (sol/answer "What is 1 plus 2 1?")))

(t/deftest "reject postfix notation"
  (t/assert-error "syntax error" (sol/answer "What is 1 2 plus?")))

(t/deftest "reject prefix notation"
  (t/assert-error "syntax error" (sol/answer "What is plus 1 2?")))

# Not in the canonical data: the answer is an integer, so a division that doesn't come out even
# drops the remainder.
(t/deftest "division with a remainder"
  (t/assert-equal 3 (sol/answer "What is 7 divided by 2?")))

# Not in the canonical data: integer division rounds toward zero, as in most languages' integer division.
(t/deftest "division rounds toward zero"
  (t/assert-equal -3 (sol/answer "What is -7 divided by 2?")))

# Not in the canonical data: dividing by zero is an error, not a number.
(t/deftest "division by zero"
  (t/assert-error "division by zero" (sol/answer "What is 1 divided by 0?")))

(t/run)
