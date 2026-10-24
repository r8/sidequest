# Introduction

A function defined inside another function can use the outer function's parameters and local bindings, and keeps them after the outer function returns.
Such a function is a _closure_.

```janet
(defn make-greeter [greeting]
  (fn [name] (string greeting ", " name "!")))

((make-greeter "Ahoy") "Ada") # => "Ahoy, Ada!"
```

A closure captures the binding, not a copy of its value, so a captured `var` can be changed with `set` (or `++`, `+=`) and keeps its new value between calls.
That gives private state that only the closure can reach:

```janet
(defn make-counter []
  (var count 0)
  (fn [] (++ count)))

(def clicks (make-counter))
(clicks) # => 1
(clicks) # => 2
```

Every call of the factory makes a fresh `var`; closures made in the same call share theirs.
