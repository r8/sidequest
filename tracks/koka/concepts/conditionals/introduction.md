# Introduction

`if … then … else` is an expression: it chooses one of two values, so it can be a function's result, a `val`, or
part of a calculation. `elif` chains more conditions, tested from the top:

```koka
fun fare(age : int) : int
  if age < 4 then 0
  elif age < 16 then 20
  else 40
```

Every branch must have the same type. An `if` without `else` is only allowed when its branch produces nothing
(the unit value `()`), as when printing.
