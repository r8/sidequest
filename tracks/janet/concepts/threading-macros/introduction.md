# Introduction

The threading macros write a chain of transformations in the order it runs.

- `(-> x f (g a))` is `(g (f x) a)`: the value goes in as the **first** argument of each step.
- `(->> x f (g a))` is `(g a (f x))`: the value goes in as the **last** argument — the right choice for `map`, `filter` and `reduce`.
- `-?>` and `-?>>` stop and return `nil` as soon as a step produces `nil`.
- `(as-> x name step …)` binds the value to `name`, so each step can put it anywhere.

```janet
(-> "  Hello  " string/trim string/ascii-lower)           # => "hello"
(->> [1 2 3 4 5] (filter odd?) (map |(* $ $)) sum)       # => 35
(-?> {:a {:b 1}} (get :x) (get :b))                       # => nil
(as-> [1 2 3] xs (map string xs) (string/join xs "-"))    # => "1-2-3"
```

Each step is a function name or a call in parentheses.
Picking the wrong arrow is the classic mistake: `(-> 10 (- 1))` is `9`, `(->> 10 (- 1))` is `-9`.
