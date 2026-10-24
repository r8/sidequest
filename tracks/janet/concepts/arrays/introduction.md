# Introduction

An array is a mutable, ordered list of values, written `@[1 2 3]` or built with `(array 1 2 3)`.
It is indexed from 0.

`length`, `get` (which returns `nil` or a default for a missing index), `in` (which raises an error instead), `first` and `last` read it.
The `array/` functions change it in place:

```janet
(def a @[:x])
(array/push a :y)        # => @[:x :y]
(array/insert a 0 :w)    # => @[:w :x :y]
(array/pop a)            # => :y
(array/remove a 0)       # => @[:x]
(put a 0 :z)             # => @[:z]
```

An array passed to a function is shared, not copied, so changes made there are visible to the caller.
