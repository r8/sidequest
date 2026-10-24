# Introduction

Wherever Janet binds a name — `def`, `var`, `let`, function parameters, `each` — you can write a pattern instead, and the parts of the value are bound to the names in it.

```janet
(def [x y] [3 4])                     # by position, from a tuple or an array
(def [head & tail] [1 2 3])           # tail is (2 3)
(def {:name name} {:name "Vega" :magnitude 0.03})  # by key, from a struct or a table
(def {:position [px py]} {:position [4 7]})        # patterns nest

(defn sum-of-point [[x y]] (+ x y))   # one parameter, taken apart
(map (fn [[x y]] [y x]) [[1 2] [3 4]]) # => @[(2 1) (4 3)]
```

Missing parts are bound to `nil` and extra ones ignored; destructuring never checks the shape of the data.
