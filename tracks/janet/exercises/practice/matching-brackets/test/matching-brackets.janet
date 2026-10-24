(import test :as t)
(import ../matching-brackets :as sol)

(t/deftest "paired square brackets"
  (t/assert-true (sol/paired? "[]")))

(t/deftest "empty string"
  (t/assert-true (sol/paired? "")))

(t/deftest "unpaired brackets"
  (t/assert-false (sol/paired? "[[")))

(t/deftest "wrong ordered brackets"
  (t/assert-false (sol/paired? "}{")))

(t/deftest "wrong closing bracket"
  (t/assert-false (sol/paired? "{]")))

(t/deftest "paired with whitespace"
  (t/assert-true (sol/paired? "{ }")))

(t/deftest "partially paired brackets"
  (t/assert-false (sol/paired? "{[])")))

(t/deftest "simple nested brackets"
  (t/assert-true (sol/paired? "{[]}")))

(t/deftest "several paired brackets"
  (t/assert-true (sol/paired? "{}[]")))

(t/deftest "paired and nested brackets"
  (t/assert-true (sol/paired? "([{}({}[])])")))

(t/deftest "unopened closing brackets"
  (t/assert-false (sol/paired? "{[)][]}")))

(t/deftest "unpaired and nested brackets"
  (t/assert-false (sol/paired? "([{])")))

(t/deftest "paired and wrong nested brackets"
  (t/assert-false (sol/paired? "[({]})")))

(t/deftest "paired and wrong nested brackets but innermost are correct"
  (t/assert-false (sol/paired? "[({}])")))

(t/deftest "paired and incomplete brackets"
  (t/assert-false (sol/paired? "{}[")))

(t/deftest "too many closing brackets"
  (t/assert-false (sol/paired? "[]]")))

(t/deftest "early unexpected brackets"
  (t/assert-false (sol/paired? ")()")))

(t/deftest "early mismatched brackets"
  (t/assert-false (sol/paired? "{)()")))

(t/deftest "math expression"
  (t/assert-true (sol/paired? "(((185 + 223.85) * 15) - 543)/2")))

(t/deftest "complex latex expression"
  (t/assert-true (sol/paired? "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")))

# Not in the canonical data: nesting deeper than a recursive solution's stack (a recursive PEG
# gave up at a few hundred levels).
(t/deftest "deeply nested brackets"
  (t/assert-true (sol/paired? (string (string/repeat "(" 1000) (string/repeat ")" 1000)))))

(t/run)
