# About

## Patterns

| Pattern | Matches | Binds |
| --- | --- | --- |
| `name` | anything | the whole value |
| `[a b c]` | tuple, array, string, buffer | elements by index; `nil` past the end |
| `[a & rest]` | the same | `rest` to a tuple of the remaining elements (empty when there are none) |
| `{:k a "s" b}` | struct, table | the value under each key, `nil` when missing |

Patterns nest to any depth: `{:position [x y] :tags [first-tag]}`.
Keys in a struct pattern can be any value, not only keywords.
A name used only to skip a position, such as `_`, is an ordinary binding; nothing special happens to it.

## Where patterns work

- `(def pattern value)` and `(var pattern value)` at the top level or in a body.
- `(let [pattern value pattern value …] body)`, whose bindings are visible only in `body`, each after the previous ones.
- Function parameters in `defn` and `fn`, including after `&` for the rest of the arguments: `(fn [{:name n} & more] …)`.
- Loop bindings: `each`, `eachp`, and the `loop` and `seq` macros.

## What destructuring does not do

Destructuring is only a shorthand for `get`.
It does not check that the value has the expected type or size: `(def [a b] 5)` raises an error because a number cannot be indexed, but `(def [a b] [1])` quietly binds `b` to `nil`, and a struct pattern against a table with different keys binds every name to `nil`.
It also cannot fall back to a default value or try another shape.

When the shape of the data decides what to do, use `match`, which tries patterns in turn, checks that tuples have the right length and literals the right value, and supports conditions; a later lesson covers it.

## Strings and buffers

A tuple pattern against a string or buffer binds bytes: `(def [a b] "hi")` binds `a` to `104`.
Usually that is a mistake; split the string first.

## Style

Destructure in the parameter list when a function only needs a few fields of its argument; it documents what the function uses.
When the whole value is needed as well, bind it to a name and destructure it in the body with `def` or `let`.
