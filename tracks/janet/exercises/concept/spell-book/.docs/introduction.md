# Introduction

Janet code is written in the same notation as Janet data.
`(+ 1 2)` in a file is a tuple of three elements — the symbol `+`, the number `1` and the number `2` — which the compiler reads and then runs as a call.
Because of this, a program can build code as ordinary data, look inside it, and run it.
This lesson is about the pieces that make that possible: _symbols_ and _quoting_.

## Symbols

A symbol is a name as a value.
When the compiler meets a symbol in code, it looks up what the name is bound to: `x` evaluates to the value of `x`.
To get the symbol itself, _quote_ it with a leading `'`:

```janet
(def potion 7)

potion     # => 7
'potion    # => potion, the symbol
(type 'potion) # => :symbol
```

Symbols look like keywords without the colon, and they are related: both are interned names, compared by value, and cheap to compare.
The difference is what happens when they are evaluated: a keyword always evaluates to itself, while a symbol is looked up.
That is why code uses keywords for data and symbols for names.

A few functions work with symbols:

```janet
(symbol "fire" "-" "ball") # => fire-ball, built from parts
(string 'fire-ball)        # => "fire-ball"
(keyword 'fire-ball)       # => :fire-ball
(symbol? 'fire-ball)       # => true
(symbol? :fire-ball)       # => false
(= 'a (symbol "a"))        # => true
```

## Quoting forms

The `'` works on any form, not just symbols.
It stops evaluation: `'(+ 1 2)` is not 3, it is the tuple `(+ 1 2)`, three elements long.

```janet
(def form '(+ 1 2))
(type form)    # => :tuple
(length form)  # => 3
(first form)   # => +, a symbol
(form 1)       # => 1
```

`'x` is shorthand for `(quote x)`.

Tuples written with parentheses and tuples written with square brackets are both tuples, but they remember which they were, because to the compiler `(f x)` is a call and `[f x]` is a tuple literal.
`tuple/type` tells them apart:

```janet
(tuple/type '(a b)) # => :parens
(tuple/type '[a b]) # => :brackets
```

## Quasiquoting

Quoting freezes everything.
Often you want a template: a form that is mostly fixed, with a few values filled in.
That is _quasiquote_, written `~`.
Inside a quasiquoted form, `,` (_unquote_) evaluates the next expression and puts its value in its place:

```janet
(def power 3)

'(fireball power)  # => (fireball power)
~(fireball ,power) # => (fireball 3)
~(,'fireball ,(* power 2)) # => (fireball 6)
```

`,;` (_unquote-splicing_) evaluates an expression that returns a tuple or array and splices its elements in, rather than inserting the collection as one element:

```janet
(def amounts [1 2 3])

~(+ ,amounts)  # => (+ (1 2 3))
~(+ ,;amounts) # => (+ 1 2 3)
```

You have already met the same `;` when calling functions: `(+ ;amounts)` splices an array into a call.

## Running code: `eval`

`eval` takes a form and compiles and runs it, returning its value:

```janet
(eval '(+ 1 2))           # => 3
(eval ~(* ,power ,power)) # => 9
```

Symbols in the form are looked up in the current environment, so core functions such as `+` are available.
`eval` is handy for experiments and for understanding how code is data, but real programs rarely need it; the next lesson's macros are the usual way to put generated code to work.

## Pitfalls

- `'x` and `x` are different things: one is a symbol, the other is whatever `x` is bound to. A missing quote means looking up a name that may not exist.
- `~(a ,b)` is a tuple with parentheses, so it prints like a call; that is fine, it is just data until it is evaluated.
- `=` compares tuples element by element, but a parenthesised tuple and a bracketed one with the same elements are not `=`. Use `deep=` to ignore the difference.
- `,` only means something inside `~`. Outside, it is an error — another reason commas cannot separate arguments.
