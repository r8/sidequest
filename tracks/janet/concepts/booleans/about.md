# About

## The values

`true` and `false` have the type `:boolean`; `nil` has the type `:nil`.
`nil` is what a lookup returns when nothing is found, what a function without a useful result returns, and what an `if` without an else-branch gives when its condition fails.
`(= nil false)` is `false`: they are different values that both count as false.

## Truthiness

Exactly two values are falsey: `false` and `nil`.
Everything else is truthy — `0`, `0.0`, `""`, `@[]`, `{}` included.
Code that wants to test for zero or emptiness says so: `(zero? n)`, `(empty? xs)`, `(= s "")`.

The predicates `true?`, `false?` and `nil?` test for the exact values, and `truthy?` for truthiness; `boolean?` tells whether a value is a boolean at all.

## `and`, `or`, `not`

`and` and `or` are macros that evaluate their arguments left to right and stop as soon as the result is known:

| Expression | Result |
| --- | --- |
| `(and)` | `true` |
| `(and 1 2)` | `2` |
| `(and 1 nil 2)` | `nil` |
| `(or)` | `nil` |
| `(or nil 3 4)` | `3` |
| `(or nil false)` | `false` |

Because they return their arguments, `or` doubles as a way to supply a default — `(or name "stranger")` — and `and` as a guard: `(and user (user-name user))` only calls `user-name` when `user` is not `nil`.
When a function promises a boolean, pass `and` and `or` only booleans, or wrap the result: `(truthy? x)`.

`not` is an ordinary function returning a boolean.
`not=` is the negation of `=`.
