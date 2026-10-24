# Introduction

A function can call itself.
That is _recursion_, and in a Lisp it is the most natural way to work through data that contains smaller data of the same shape: a list whose rest is a list, a tree whose branches are trees, a box with a box inside.

## Base case and recursive case

Every recursive function has two parts:

- a **base case**, small enough to answer directly, without calling itself;
- a **recursive case**, which does a little work and calls the function again on something smaller, getting closer to the base case each time.

Here is the sum of the numbers from 1 to `n`:

```janet
(defn sum-to
  "(sum-to n) -> the sum of 1 + 2 + … + n"
  [n]
  (if (= n 0)
    0                       # base case: nothing to add
    (+ n (sum-to (- n 1)))))  # recursive case: n plus the sum of the rest

(sum-to 4) # => 10
```

`(sum-to 4)` is `(+ 4 (sum-to 3))`, which is `(+ 4 (+ 3 (sum-to 2)))`, and so on until `(sum-to 0)` answers `0` and all the pending additions are done on the way back.
Without the base case the function would call itself forever.

## Recursion over tuples

A tuple or an array can be seen as its first element followed by the rest of it.
`first` returns the first element (or `nil` for an empty one), and `(slice xs 1)` returns everything after it, as a tuple:

```janet
(defn total
  "(total xs) -> the sum of the numbers in xs"
  [xs]
  (if (empty? xs)
    0
    (+ (first xs) (total (slice xs 1)))))

(total [3 4 5]) # => 12
```

`empty?` is true for an empty tuple or array, which makes it the usual base case.
Be careful with the order: `(slice [] 1)` is an error, because index 1 is past the end of an empty tuple, so check for empty before slicing.

## Recursive data

Data can be recursive too.
A pair `[value rest]`, where `rest` is either another pair or `nil`, is a _linked list_:

```janet
(def chain [1 [2 [3 nil]]])
```

A function over it follows the same shape: `nil` is the base case, and a pair is handled by doing something with its first half and recursing into the second.

```janet
(defn chain-length
  "(chain-length chain) -> how many values the chain holds"
  [chain]
  (if (nil? chain)
    0
    (+ 1 (chain-length (get chain 1)))))

(chain-length [1 [2 [3 nil]]]) # => 3
```

A recursive function can also _build_ recursive data, by putting its own result inside what it returns.
Splicing with `;` helps when the result is a flat tuple:

```janet
(defn evens
  "(evens xs) -> a tuple of the even numbers of xs"
  [xs]
  (cond
    (empty? xs) []
    (even? (first xs)) [(first xs) ;(evens (slice xs 1))]
    (evens (slice xs 1))))

(evens [1 2 3 4]) # => (2 4)
```

## Tail calls and accumulators

When the recursive call is the very last thing a function does — its result is returned as it is, with nothing left to add — it is a _tail call_.
Janet reuses the current call's space for a tail call, so a tail-recursive function runs in constant memory however deep it goes.
The usual way to make a function tail-recursive is to carry the result so far in an extra parameter, an _accumulator_:

```janet
(defn sum-to-acc
  "(sum-to-acc n acc) -> acc plus the sum of 1 to n"
  [n acc]
  (if (= n 0)
    acc
    (sum-to-acc (- n 1) (+ acc n))))

(sum-to-acc 4 0) # => 10
```

`sum-to` above is not tail-recursive, since the `+` waits for the inner call.
Janet's call stack grows as needed, so that version works for deep inputs too, but each pending call costs memory.

## Pitfalls

- A missing or unreachable base case recurses until memory runs out. Make sure every recursive call gets closer to it.
- Test the base case first: `(first xs)` on an empty tuple is `nil`, and arithmetic on `nil` is an error.
- `slice` returns a tuple even when given an array, so a recursive result built that way is a tuple.
