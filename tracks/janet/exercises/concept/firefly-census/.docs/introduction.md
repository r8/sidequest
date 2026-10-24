# Introduction

So far every value has been bound once, with `def`, and never changed.
Loops need something that changes — a running total, a position in an array — so this lesson starts with variables.

## Variables: `var` and `set`

`var` binds a name like `def` does, but the binding can be changed later with `set`:

```janet
(var lanterns 3)
(set lanterns 5)
lanterns            # => 5
```

Trying to `set` a name made with `def` is a compile error (`cannot set constant`), which is why `def` is the default and `var` the exception.

A few shorthands update a variable in place:

```janet
(var n 10)
(++ n)        # n is now 11
(-- n)        # 10 again
(+= n 5)      # 15
(*= n 2)      # 30
(-= n 4)      # 26
```

A `var` inside a function is local to that call of the function: every call starts with a fresh one.

## `each`

`each` runs its body once for every element of an array or tuple, binding a name to the element:

```janet
(defn longest
  "(longest words) -> the length of the longest string in words"
  [words]
  (var best 0)
  (each word words
    (when (> (length word) best)
      (set best (length word))))
  best)

(longest ["owl" "nightjar" "bat"])   # => 8
```

Like every loop in Janet, `each` itself returns `nil`, so a function that loops ends with the variable holding its result, as `best` above.

## `for`

`for` counts: it binds a name to each integer from a start value up to, but not including, an end value.

```janet
(def squares @[])
(for i 0 4
  (array/push squares (* i i)))
squares   # => @[0 1 4 9]
```

`squares` can be a `def` here: the loop changes the array's contents, never which array the name refers to.

`for` is the loop to reach for when you need the index, for instance to read or replace an element of an array with `get` and `put`:

```janet
(def readings @[3 5 8])
(for i 0 (length readings)
  (put readings i (* 10 (get readings i))))
readings  # => @[30 50 80]
```

## `while`

`while` repeats its body as long as its condition is truthy.
It is the most general loop: the condition can be anything, and the body decides how the loop moves on.

```janet
(var lamp 1)
(while (< lamp 100)
  (*= lamp 3))
lamp   # => 243
```

A `while` loop whose condition never becomes false runs forever, so make sure the body moves it towards the end — usually by updating a variable that the condition tests.

## `break`

`break` leaves the innermost loop at once.
Combined with a variable, it lets a loop stop as soon as it has found what it was looking for:

```janet
(defn first-negative
  "(first-negative numbers) -> the first negative number, or nil"
  [numbers]
  (var found nil)
  (each n numbers
    (when (neg? n)
      (set found n)
      (break)))
  found)

(first-negative [4 -2 7 -9])   # => -2
```

## Choosing a loop

- `each` when you need every element and not its position.
- `for` when you need the positions, or simply to count.
- `while` when the loop's end depends on something else, or the step is not one.

Janet also has a much more powerful `loop` macro, and functions such as `map` and `filter` that replace many loops; later lessons cover both.

## Pitfalls

- Loops return `nil`. Keep the result in a `var` and return the variable after the loop.
- `for`'s end value is not included: `(for i 0 3 …)` runs for 0, 1 and 2.
- `each` over a string visits its bytes, as numbers.
