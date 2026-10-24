# About

## Qualified names

Every Koka definition has a fully qualified name: its module path, an optional local qualifier, and the plain
name. `show` for integers is `std/core/int/show`; it can be written in full, or shortened as long as it stays
unambiguous: `int/show`, `core/int/show`. Qualifying is always allowed and never changes the meaning — it only
removes the need for the compiler to choose.

## Static overloading

When a plain name has several definitions in scope, the compiler resolves each use from the types it knows at
that point: the argument types, and with dot-selection the receiver's type. If more than one candidate fits — or
the types are still unknown, as in `fun add(a, b) a + b` — it reports that the identifier "cannot be resolved"
and lists the candidates. Add a type annotation or a qualifier.

This is resolution at compile time, not dispatch at run time: once the program type-checks, every name refers to
exactly one definition. Koka has no type classes; overloading plus implicit parameters cover what they are
usually used for.

## Local qualifiers

Two definitions with the same plain name in one module are an error ("already defined in this module") unless
they have different local qualifiers. By convention the qualifier is the type the function is about —
`money/show`, `measure/show` — but any name works, and nested ones such as `default/compare/eq` are allowed.

```koka
fun int/describe(i : int) : string
  "the number " ++ i.show

fun string/describe(s : string) : string
  "the text " ++ s.show

describe(3) ++ ", " ++ describe("hi")
```

## Overloading operators

Operators are ordinary names in parentheses: `fun money/(==)(a : money, b : money) : bool`,
`fun vec/(+)(a : vec, b : vec) : vec`. Defining `==` for a type makes `x == y` work for it, and lets the type's
values be found by implicit `?(==)` parameters — including inside lists and tuples, whose `==` takes the
elements' `==` implicitly. With a `cmp` in scope, the library's `default/cmp/…` conversions also give a type
`<`, `>`, `<=`, `>=` and `==` for free.

## Pitfalls

- A field accessor and a library function can clash: a struct field named `id` conflicts with std's `id`.
- The more overloads a name has, the more annotations its uses may need; give your functions distinct names
  unless they really do the same thing for different types.
