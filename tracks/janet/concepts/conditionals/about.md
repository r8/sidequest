# About

## `if` and `do`

`if` is a special form: `(if condition then else)`.
Only the branch selected is evaluated, and its value is the value of the `if`.
The else-branch is optional; without it a failed condition gives `nil`.

Each branch is exactly one expression.
`(do a b c)` evaluates several expressions in order and returns the last, so a branch that has to do more than one thing uses `do`.

## `when` and `unless`

`(when condition body…)` is `(if condition (do body…))`, and `unless` inverts the condition.
They signal "there is no else-branch" to the reader.

## `cond`

```janet
(cond
  (< n 0) "negative"
  (= n 0) "zero"
  "positive")
```

Conditions are tried in order and only until one is truthy, so later conditions can assume earlier ones failed.
An odd final form is the default; without one, a `cond` where nothing matches returns `nil`.

## `case`

```janet
(case command
  "start" (start!)
  "stop" (stop!)
  (complain command))
```

`case` evaluates its first argument once and compares it with each test value in turn using `=`, stopping at the first match.
The test values are usually literals (numbers, strings, keywords), though they are ordinary expressions: a name bound with `def` works too.
For anything more than equality, use `cond`, or `match`, which matches structure and is covered in a later lesson.

## `if-let` and `when-let`

`(if-let [x (lookup key)] (use x) fallback)` binds a name to a value and branches on whether it is truthy, a common pattern when a function may return `nil`.
`when-let` is the same without an else-branch.

## Everything returns a value

Because conditionals are expressions, they can sit anywhere a value is expected:

```janet
(string "The door is " (if open "open" "closed") ".")
```
