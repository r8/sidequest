# Introduction

Code that works with tuples and structs spends a lot of time taking them apart: `(get point 0)`, `(get point 1)`, `(star :name)`.
_Destructuring_ does it in one step: instead of binding a name to the whole value, you write the shape you expect, with names where the parts go, and Janet binds each name to the matching part.

## Tuples and arrays

A tuple of names in square brackets matches a tuple or an array by position:

```janet
(def [x y] [3 4])
x # => 3
y # => 4
```

Missing elements are bound to `nil`, and extra ones are ignored:

```janet
(def [a b c] [1 2])   # a is 1, b is 2, c is nil
(def [first-one] [7 8 9]) # first-one is 7
```

`&` followed by a name collects all the remaining elements into a tuple:

```janet
(def [head & tail] [1 2 3 4])
head # => 1
tail # => (2 3 4)

(def [only & none] [5])
none # => (), empty
```

## Structs and tables

A struct of keys and names matches a struct or a table by key:

```janet
(def {:name name :age age} {:name "Vega" :age 455})
name # => "Vega"
age  # => 455
```

Each key on the left is looked up in the value and its value bound to the name on the right.
A key that is missing gives `nil`, and keys you do not mention are ignored, so you only name the parts you need.

## Nesting

Patterns can be nested to reach into data of data:

```janet
(def {:name name :position [x y]} {:name "Deneb" :position [12 -3]})
[name x y] # => ("Deneb" 12 -3)

(def [[x1 y1] [x2 y2]] [[0 0] [3 4]])
```

## Destructuring parameters

Function parameters are patterns too.
A function whose argument is a point can take it apart in its parameter list:

```janet
(defn sum-of-point
  "(sum-of-point point) -> x + y of an [x y] point"
  [[x y]]
  (+ x y))

(sum-of-point [3 4]) # => 7

(defn greeting
  "(greeting person) -> a greeting for a {:name …} struct"
  [{:name name}]
  (string "Hello, " name))
```

Note the double brackets in `[[x y]]`: the outer pair is the parameter list, the inner one is the pattern of its single parameter.

This works for `fn` as well, which makes destructuring especially handy with `map` and friends:

```janet
(map (fn [[x y]] (* x y)) [[1 2] [3 4]]) # => @[2 12]
```

## Destructuring in `let` and loops

`let` binds names for the expressions inside it only.
It takes a tuple of alternating patterns and values, then a body:

```janet
(let [[x y] [3 4]
      sum (+ x y)]
  (* sum 2)) # => 14
```

`each` destructures each element, which you have already seen with `eachp` and its `[key value]` pairs:

```janet
(each [name score] [["Ada" 3] ["Bo" 5]]
  (print name ": " score))
```

## Pitfalls

- Destructuring never checks the shape. A pattern that does not fit the data simply binds `nil`, which shows up later as a confusing error. When the shape matters, check it — a later lesson's `match` does that for you.
- A string or buffer matches a tuple pattern too, by bytes: `(def [a b] "hi")` binds `a` to `104`.
- `[x y]` as a parameter list means two parameters; `[[x y]]` means one parameter that is taken apart. Mixing them up gives an arity error.
