# Introduction

Janet's booleans are `true` and `false`; `nil` is a separate value meaning "nothing".
Comparisons return booleans.

Any value can be a condition, and only `false` and `nil` are falsey: `0`, `""` and empty collections are all truthy.

`not` negates a value.
`and` and `or` take any number of arguments, short-circuit, and return one of their arguments: `and` the first falsey one (or the last), `or` the first truthy one (or the last).

```janet
(and 1 nil 3)   # => nil
(or false 7)    # => 7
(not 0)         # => false
```
