# Introduction

A parameter marked with `?` is _implicit_: the compiler supplies it at each call by finding a definition of the
same name and the right type at the call site.

```koka
fun shout(x : a, ?show : (a) -> string) : string
  x.show ++ "!"

shout(3)                 // "3!", passing int/show
shout([1, 2])            // "[1,2]!", passing list's show, itself given int/show
shout(3, ?show = fn(n) "#" ++ n.show)    // "#3!": given explicitly
```

The usual implicits are `?show : (a) -> string`, `?(==) : (a, a) -> bool` and `?cmp : (a, a) -> order` (`Lt`,
`Eq` or `Gt`). Define those functions for your own types and every polymorphic function asking for them — such
as the test harness's `assert-equal` — can use your type.
