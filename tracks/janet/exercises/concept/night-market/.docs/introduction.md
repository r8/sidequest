# Introduction

## Booleans and nil

Janet has two boolean values, `true` and `false`, and a separate value `nil` that means "nothing here".
Comparisons such as `<` and `=` return booleans:

```janet
(< 3 5)       # => true
(= 2 3)       # => false
```

Every value can be used as a condition.
Only two values count as false: `false` and `nil`.
Everything else is _truthy_, including `0`, the empty string `""` and empty collections — a common surprise for people coming from C, JavaScript or Python.

```janet
(if 0 "truthy" "falsey")     # => "truthy"
(if nil "truthy" "falsey")   # => "falsey"
```

## `and`, `or` and `not`

`not` turns a truthy value into `false` and a falsey one into `true`.

`and` and `or` take any number of arguments and stop evaluating as soon as the answer is known.
They return one of their arguments, not necessarily a boolean:

- `and` returns the first falsey argument, or the last argument if all are truthy;
- `or` returns the first truthy argument, or the last argument if none is.

```janet
(and true (< 1 2))   # => true
(and 1 nil 3)        # => nil
(or false 7)         # => 7
(or nil false)       # => false
(not 0)              # => false, 0 is truthy
```

When a function's result should be a real boolean, make sure every argument you give `and` or `or` is one: comparisons always are.

## `if`

`if` takes a condition, the expression to evaluate when it is truthy, and optionally the expression to evaluate otherwise.
It returns the value of whichever branch ran.

```janet
(defn parity [n]
  (if (= 0 (mod n 2)) "even" "odd"))

(parity 3)                # => "odd"
(if false "never")        # => nil, a missing else-branch gives nil
```

Each branch is a single expression.
To do several things in one branch, wrap them in `do`, which evaluates its expressions in order and returns the last.

## `when` and `unless`

`when` runs its body only when the condition is truthy and returns `nil` otherwise; `unless` is the opposite.
Use them when there is no else-branch; their body may hold several expressions.

```janet
(when (> 5 3) "five is bigger")   # => "five is bigger"
(unless (> 5 3) "never")          # => nil
```

## `cond`

`cond` replaces a chain of `if`s.
It takes pairs of a condition and a result, tries the conditions in order, and returns the result of the first truthy one.
A single expression at the end, without a condition, is the default; without one, `cond` returns `nil` when nothing matches.

```janet
(defn size-of [n]
  (cond
    (< n 10) "small"
    (< n 100) "medium"
    "large"))

(size-of 42)   # => "medium"
```

Because the conditions are tried in order, a later condition can rely on the earlier ones having been false: above, the second test does not need to say `(>= n 10)`.

## `case`

`case` compares one value against several constants with `=` and returns the result paired with the first match.
As with `cond`, a lone last expression is the default.

```janet
(defn dice-name [n]
  (case n
    1 "ace"
    6 "six"
    "other"))

(dice-name 6)   # => "six"
(dice-name 3)   # => "other"
```

`case` only ever tests equality, so it suits fixed values such as numbers and strings; `cond` handles any condition.

## Pitfalls

- `0` and `""` are truthy. Test them explicitly: `(= n 0)`, `(zero? n)`.
- Without an else-branch or default, `if`, `when`, `cond` and `case` quietly return `nil`.
- `and` and `or` return values, not booleans: `(or nil "x")` is `"x"`.
