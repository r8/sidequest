# Introduction

A recursive function calls itself.
It has a **base case**, answered directly, and a **recursive case**, which calls the function again on something smaller:

```janet
(defn total
  "(total xs) -> the sum of the numbers in xs"
  [xs]
  (if (empty? xs)
    0
    (+ (first xs) (total (slice xs 1)))))

(total [3 4 5]) # => 12
```

Recursion follows the shape of recursive data, such as a pair `[value rest]` whose `rest` is another pair or `nil`: `nil` is the base case, and a pair combines its value with the answer for its rest.

A call that is the last thing a function does is a _tail call_, and Janet runs it without using more memory.
Carrying the result so far in an extra parameter, an accumulator, turns many recursive functions into tail-recursive ones.
