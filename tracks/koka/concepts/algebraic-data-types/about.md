# About

## Sums of products

An algebraic data type is a choice between constructors (a _sum_), each of which holds some fields (a
_product_). A struct is the special case with one constructor; an enumeration is the case where no constructor has
fields.

```koka
pub type shape
  Circle(radius : float64)
  Rect(width : float64, height : float64)
  Dot
```

The declaration defines the type, its constructors (functions, or plain values for those without fields), an
`is-…` test per constructor (`s.is-circle`), and a reading function for each field that every constructor
declares with the same name and type. `pub type` exports all of it. Constructors take named arguments,
`Rect(height = 2.0, width = 3.0)`, and their fields may have defaults, as a struct's can.

The standard library's own types are built this way: `bool` is `False | True`, `maybe<a>` is
`Nothing | Just(value : a)`, `either<a,b>` is `Left | Right`, and `list<a>` is `Nil | Cons(head, tail)`.

## Patterns

- `Rect(w, h)` binds fields by position, `Rect(height = h)` by name, `Rect` (no parentheses) matches any `Rect`.
- Fields can be matched against literals (`Card(_, True)`), constructors (`Latte(Large, _)`) and further patterns,
  to any depth.
- `_` matches anything and binds nothing; a name on its own matches anything and binds it.
- `| condition` adds a guard: `Circle(r) | r > 10.0 -> "big circle"`.
- Branches are tried in order, so put specific patterns before general ones.

## Exhaustiveness and the `exn` effect

Koka checks which constructors a `match` covers. When some are missing, it inserts a branch that throws a
pattern-match exception and adds `exn` to the function's inferred effect. A function annotated as total, such as
`fun f(s : shape) : float64`, is then rejected — the compiler error mentions `exn` rather than a missing case.
Cover every constructor, or add a final `_` branch deliberately.

## Choosing between a struct and a type

Use a struct when every value has the same fields, and a type with constructors when values come in different
forms. When some alternatives share fields, give each constructor those fields with the same name, and Koka will
define the reading function for them.

## Nothing derived

Koka does not generate `show`, `==` or ordering for user types. A `match` writes them in a few lines; a later lesson
shows how to name them so that library functions such as `assert-equal` and `list/show` find them.

## Open types

A type declared `open type` can be extended with more constructors in other modules (`extend type`). The standard
library's `exception-info` is one; most programs never need it.
