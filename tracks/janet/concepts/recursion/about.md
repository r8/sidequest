# About

## The shape of a recursive function

1. Handle the base case — an empty collection, `nil`, zero — without recursing.
2. Otherwise do one step of the work and call the function on a smaller input.
3. Combine that step with the result of the call.

Every call must move towards the base case, or the recursion never ends.

```janet
(defn countdown
  "(countdown n) -> a tuple from n down to 1"
  [n]
  (if (<= n 0)
    []
    [n ;(countdown (- n 1))]))

(countdown 3) # => (3 2 1)
```

## Recursion over sequences

`first` and `(slice xs 1)` split a tuple or array into its head and its rest.
Check `empty?` first: `(slice [] 1)` raises an error, and `(first [])` is `nil`.
`slice` always returns a tuple, even for an array.

Slicing copies the rest of the sequence on every call, so this style costs time proportional to the square of the length.
For long sequences, recurse on an index instead, or use the loops and sequence functions Janet provides (`each`, `map`, `reduce`), which a recursive definition is often a stepping stone to.

## Recursive data

Recursion is at its best on data that contains smaller data of the same kind: nested tuples, trees made of structs with `:left` and `:right` children, a directory of directories.
The function's cases mirror the data's: one per kind of node.

```janet
(defn depth
  "(depth tree) -> the number of levels of a tree of {:left :right} structs"
  [tree]
  (if (nil? tree)
    0
    (+ 1 (max (depth (tree :left)) (depth (tree :right))))))
```

## Tail calls

A call whose result the function returns unchanged is in _tail position_.
Janet compiles a tail call to reuse the current stack frame — stack traces mark it `(tail call)` — so a tail-recursive function runs in constant stack space.

```janet
(defn sum-to
  "(sum-to n acc) -> acc plus 1 + 2 + … + n"
  [n acc]
  (if (= n 0)
    acc
    (sum-to (- n 1) (+ acc n))))

(sum-to 10000000 0) # => 50000005000000
```

The extra parameter is an _accumulator_: it carries the partial result forward, so nothing is left to do after the call returns.
A public function often hides it behind a wrapper that passes the starting value.

Non-tail recursion is fine too: Janet's stack lives on the heap and grows as needed, so deep recursion rarely fails, though each pending call costs memory.

## Mutual recursion

Two functions can call each other, but Janet compiles a file one top-level form at a time, and a name must exist before code that uses it is compiled.
`varfn` solves this: it binds a function to a var, and a second `varfn` of the same name replaces the function in that var, so a placeholder can be declared first.

```janet
(varfn my-odd? [n] nil)            # placeholder, replaced below

(defn my-even? [n]
  (if (= n 0) true (my-odd? (- n 1))))

(varfn my-odd? [n]
  (if (= n 0) false (my-even? (- n 1))))

(my-even? 10) # => true
```
