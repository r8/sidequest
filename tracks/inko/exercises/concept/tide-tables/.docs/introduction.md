# Introduction

Inko has three loops: `while`, `loop` and `for`. All three are controlled with `break` and `next`.

## while

`while` repeats its body for as long as its condition is `true`:

```inko
let mut count = 3

while count > 0 {
  count -= 1
}
```

The condition is checked before every round, so a `while` whose condition starts out false never runs its body.

## loop

`loop` repeats forever, until something stops it:

```inko
let mut attempts = 0

loop {
  attempts += 1

  if attempts == 5 { break }
}
```

## break and next

`break` leaves the innermost loop at once. `next` skips the rest of the body and starts the next round (other
languages call it `continue`). Both work in every kind of loop:

```inko
let mut number = 0
let mut odd_sum = 0

while number < 10 {
  number += 1

  if number % 2 == 0 { next }

  odd_sum += number
}

odd_sum # => 25
```

`return` inside a loop leaves the whole method, which is often the simplest way to stop searching once you've found
what you're looking for.

## for

`for` takes each value from something that can be iterated, one at a time:

```inko
let names = ['Ada', 'Grace', 'Alan']
let mut letters = 0

for name in names.iter {
  letters += name.size
}

letters # => 12
```

`names.iter` lends the loop each value in turn, and the array is still usable afterwards. A `for` loop over the
array itself (`for name in names`) _moves_ the values out of it, using it up; prefer `iter` unless you are done with
the array.

A `for` loop can take values apart with a pattern, just like `let`:

```inko
let people = [('Ada', 36), ('Alan', 41)]

for (name, age) in people.iter {
  …
}
```

Call `iter` on an array that is stored in a variable (or passed in as an argument), not on an array literal written
in the loop itself: `for x in [1, 2].iter { … }` panics with "can't drop a value of type 'Array' as it still has 1
reference(s)", because the temporary array is gone while the loop still borrows it. Iterate the literal itself
instead (`for x in [1, 2] { … }`).

## Ranges

A _range_ is a sequence of integers. `Int` has two methods that create one:

```inko
0.until(5) # 0, 1, 2, 3 and 4: up to but not including 5
1.to(5)    # 1, 2, 3, 4 and 5: up to and including 5
```

Ranges are perfect for counting loops, such as walking over the indexes of an array:

```inko
let heights = [120, 180, 150]

for index in 0.until(heights.size) {
  let height = heights.get(index).or(0)
  …
}
```

`step_by` counts in bigger steps, and a range knows its size and what it contains:

```inko
for minute in 0.to(60).step_by(15) {
  # 0, 15, 30, 45 and 60
}

1.to(10).size          # => 10
1.until(10).contains?(10) # => false
```

Ranges only count upwards: `10.to(1)` is empty. To count down, use `while`, or `reverse_iter` on an array.

## times

`Int.times` runs a closure that many times, passing it the count from zero. Closures have their own lesson; for now
it's enough to know that the code between `fn (i) {` and `}` runs once per number:

```inko
let squares = []

3.times(fn (i) { squares.push(i * i) })

squares # => [0, 1, 4]
```

A variable can't be assigned a new value from inside such a closure (`3.times(fn (i) { total += i })` doesn't
compile), so use a `for` or `while` loop when you are adding up a number.

## Collecting results

To build a new array in a loop, start with an empty one and `push` into it:

```inko
let numbers = [1, 2, 3]
let doubled = []

for number in numbers.iter {
  doubled.push(number * 2)
}

doubled # => [2, 4, 6]
```
