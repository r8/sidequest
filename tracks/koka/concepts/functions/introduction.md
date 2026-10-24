# Introduction

A Koka function takes any number of typed parameters. A parameter may have a default value, which lets a call
leave it out, and any argument may be passed by name:

```koka
fun postage(weight : int, express : bool = False) : int
  val standard = 5 + 2 * weight
  if express then standard * 2 else standard

postage(3)                    // 11
postage(3, express = True)    // 22
```

A body may define local helper functions with `fun`; they can use the enclosing function's parameters and are
invisible elsewhere.
