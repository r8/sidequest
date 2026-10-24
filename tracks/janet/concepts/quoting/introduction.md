# Introduction

Janet code is Janet data: `(+ 1 2)` is a tuple of a symbol and two numbers.
_Quoting_ stops evaluation so you get the data instead of the result:

```janet
'(+ 1 2)          # => (+ 1 2), a tuple
(eval '(+ 1 2))   # => 3
```

_Quasiquote_ (`~`) makes a template; inside it, `,` inserts a value and `,;` splices in the elements of a tuple or array:

```janet
(def power 3)
(def amounts [1 2 3])

~(fireball ,power) # => (fireball 3)
~(+ ,;amounts)     # => (+ 1 2 3)
```

`eval` compiles and runs a form in the current environment.
Parenthesised and bracketed tuples are both tuples; `tuple/type` returns `:parens` or `:brackets`.
