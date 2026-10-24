(import test :as t)
(import ../forth :as sol)

(t/deftest "numbers just get pushed onto the stack"
  (t/assert-equal [1 2 3 4 5] (sol/evaluate ["1 2 3 4 5"])))

(t/deftest "pushes negative numbers onto the stack"
  (t/assert-equal [-1 -2 -3 -4 -5] (sol/evaluate ["-1 -2 -3 -4 -5"])))

(t/deftest "can add two numbers"
  (t/assert-equal [3] (sol/evaluate ["1 2 +"])))

(t/deftest "errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["+"])))

(t/deftest "errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 +"])))

(t/deftest "more than two values on the stack"
  (t/assert-equal [1 5] (sol/evaluate ["1 2 3 +"])))

(t/deftest "can subtract two numbers"
  (t/assert-equal [-1] (sol/evaluate ["3 4 -"])))

(t/deftest "subtraction > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["-"])))

(t/deftest "subtraction > errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 -"])))

(t/deftest "subtraction > more than two values on the stack"
  (t/assert-equal [1 9] (sol/evaluate ["1 12 3 -"])))

(t/deftest "can multiply two numbers"
  (t/assert-equal [8] (sol/evaluate ["2 4 *"])))

(t/deftest "multiplication > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["*"])))

(t/deftest "multiplication > errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 *"])))

(t/deftest "multiplication > more than two values on the stack"
  (t/assert-equal [1 6] (sol/evaluate ["1 2 3 *"])))

(t/deftest "can divide two numbers"
  (t/assert-equal [4] (sol/evaluate ["12 3 /"])))

(t/deftest "performs integer division"
  (t/assert-equal [2] (sol/evaluate ["8 3 /"])))

(t/deftest "errors if dividing by zero"
  (t/assert-error "divide by zero" (sol/evaluate ["4 0 /"])))

(t/deftest "division > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["/"])))

(t/deftest "division > errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 /"])))

(t/deftest "division > more than two values on the stack"
  (t/assert-equal [1 4] (sol/evaluate ["1 12 3 /"])))

# Not in the canonical data: integer division rounds toward zero, as in most languages' integer division.
(t/deftest "division > rounds toward zero"
  (t/assert-equal [-3] (sol/evaluate ["-7 2 /"])))

(t/deftest "addition and subtraction"
  (t/assert-equal [-1] (sol/evaluate ["1 2 + 4 -"])))

(t/deftest "multiplication and division"
  (t/assert-equal [2] (sol/evaluate ["2 4 * 3 /"])))

(t/deftest "multiplication and addition"
  (t/assert-equal [13] (sol/evaluate ["1 3 4 * +"])))

(t/deftest "addition and multiplication"
  (t/assert-equal [7] (sol/evaluate ["1 3 4 + *"])))

(t/deftest "copies a value on the stack"
  (t/assert-equal [1 1] (sol/evaluate ["1 dup"])))

(t/deftest "copies the top value on the stack"
  (t/assert-equal [1 2 2] (sol/evaluate ["1 2 dup"])))

(t/deftest "dup > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["dup"])))

(t/deftest "removes the top value on the stack if it is the only one"
  (t/assert-equal [] (sol/evaluate ["1 drop"])))

(t/deftest "removes the top value on the stack if it is not the only one"
  (t/assert-equal [1] (sol/evaluate ["1 2 drop"])))

(t/deftest "drop > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["drop"])))

(t/deftest "swaps the top two values on the stack if they are the only ones"
  (t/assert-equal [2 1] (sol/evaluate ["1 2 swap"])))

(t/deftest "swaps the top two values on the stack if they are not the only ones"
  (t/assert-equal [1 3 2] (sol/evaluate ["1 2 3 swap"])))

(t/deftest "swap > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["swap"])))

(t/deftest "swap > errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 swap"])))

(t/deftest "copies the second element if there are only two"
  (t/assert-equal [1 2 1] (sol/evaluate ["1 2 over"])))

(t/deftest "copies the second element if there are more than two"
  (t/assert-equal [1 2 3 2] (sol/evaluate ["1 2 3 over"])))

(t/deftest "over > errors if there is nothing on the stack"
  (t/assert-error "empty stack" (sol/evaluate ["over"])))

(t/deftest "over > errors if there is only one value on the stack"
  (t/assert-error "only one value on the stack" (sol/evaluate ["1 over"])))

(t/deftest "can consist of built-in words"
  (t/assert-equal [1 1 1] (sol/evaluate [": dup-twice dup dup ;" "1 dup-twice"])))

(t/deftest "execute in the right order"
  (t/assert-equal [1 2 3] (sol/evaluate [": countup 1 2 3 ;" "countup"])))

(t/deftest "can override other user-defined words"
  (t/assert-equal [1 1 1] (sol/evaluate [": foo dup ;" ": foo dup dup ;" "1 foo"])))

(t/deftest "can override built-in words"
  (t/assert-equal [1 1] (sol/evaluate [": swap dup ;" "1 swap"])))

(t/deftest "can override built-in operators"
  (t/assert-equal [12] (sol/evaluate [": + * ;" "3 4 +"])))

(t/deftest "can use different words with the same name"
  (t/assert-equal [5 6] (sol/evaluate [": foo 5 ;" ": bar foo ;" ": foo 6 ;" "bar foo"])))

(t/deftest "can define word that uses word with the same name"
  (t/assert-equal [11] (sol/evaluate [": foo 10 ;" ": foo foo 1 + ;" "foo"])))

(t/deftest "cannot redefine non-negative numbers"
  (t/assert-error "illegal operation" (sol/evaluate [": 1 2 ;"])))

(t/deftest "cannot redefine negative numbers"
  (t/assert-error "illegal operation" (sol/evaluate [": -1 2 ;"])))

(t/deftest "errors if executing a non-existent word"
  (t/assert-error "undefined operation" (sol/evaluate ["foo"])))

(t/deftest "only defines locally"
  (t/assert-equal [0] (sol/evaluate [": + - ;" "1 1 +"]))
  (t/assert-equal [2] (sol/evaluate ["1 1 +"])))

(t/deftest "DUP is case-insensitive"
  (t/assert-equal [1 1 1 1] (sol/evaluate ["1 DUP Dup dup"])))

(t/deftest "DROP is case-insensitive"
  (t/assert-equal [1] (sol/evaluate ["1 2 3 4 DROP Drop drop"])))

(t/deftest "SWAP is case-insensitive"
  (t/assert-equal [2 3 4 1] (sol/evaluate ["1 2 SWAP 3 Swap 4 swap"])))

(t/deftest "OVER is case-insensitive"
  (t/assert-equal [1 2 1 2 1] (sol/evaluate ["1 2 OVER Over over"])))

(t/deftest "user-defined words are case-insensitive"
  (t/assert-equal [1 1 1 1] (sol/evaluate [": foo dup ;" "1 FOO Foo foo"])))

(t/deftest "definitions are case-insensitive"
  (t/assert-equal [1 1 1 1] (sol/evaluate [": SWAP DUP Dup dup ;" "1 swap"])))

# Not in the canonical data: a number is only digits (with an optional minus sign), so 1.5 is an
# undefined word rather than a number to push.
(t/deftest "a decimal fraction is not a number"
  (t/assert-error "undefined operation" (sol/evaluate ["1.5"])))

# Not in the canonical data: a word that a host language would read as a number in another
# notation can still be defined.
(t/deftest "can define a word that looks like a hexadecimal number"
  (t/assert-equal [16] (sol/evaluate [": 0x10 16 ;" "0x10"])))

# Not in the canonical data: a line with no words is a valid (empty) program.
(t/deftest "empty and blank lines do nothing"
  (t/assert-equal [1 2] (sol/evaluate ["1" "" "   " "2"])))

# Not in the canonical data: words are separated by any whitespace, however much.
(t/deftest "words are separated by any whitespace"
  (t/assert-equal [3] (sol/evaluate ["1  2\t+"])))

(t/run)
