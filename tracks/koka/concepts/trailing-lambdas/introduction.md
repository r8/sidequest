# Introduction

When the last argument of a call is a function, Koka lets you write it after the parentheses. These pairs are
the same call:

```koka
xs.map(fn(x) x * 10)
xs.map fn(x) x * 10

xs.foldl(0, fn(acc, x) acc + x)
xs.foldl(0) fn(acc, x) acc + x
```

A trailing lambda may have an indented body of several lines, and a function without parameters can be written
as a block in braces: `{ 41 }` is `fn() 41`, as in the tests' `test("name") { … }`.
