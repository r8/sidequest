# Introduction

Several Koka functions may share a name when their argument types differ: `3.show` and `True.show` call
`int/show` and `bool/show`, chosen by the compiler from the types. Within one module, definitions that share a
plain name get a _local qualifier_ before a slash:

```koka
fun point/show(p : point) : string
  "(" ++ p.x.show ++ ", " ++ p.y.show ++ ")"

fun colour/show(c : colour) : string
  …
```

Calls use the plain name, `p.show`; when the types do not decide, write the qualifier: `point/show(p)`.
Operators are names too, so `fun point/(==)(p : point, q : point) : bool` defines `==` for points.
