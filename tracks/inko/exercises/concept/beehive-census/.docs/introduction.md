# Introduction

An _iterator_ hands out values one at a time. You've used them with `for`: `numbers.iter` returns an iterator over
an array, and `for` takes its values until there are none left. Iterators can do much more than feed a loop.
They have methods that transform, filter and combine values, most of which take a closure.

## Where iterators come from

```inko
let numbers = [3, 10, 0, 7]

numbers.iter      # the values of an array, borrowed
1.to(5).iter      # the integers 1 to 5
'bee'.chars       # the characters of a string
```

Every iterator implements the `Iter` trait, whose one essential method is `next`: it returns the next value, or
`None` when the iterator is finished. A `for` loop calls `next` until then, and so do the methods below.

## Transforming and filtering

`map` turns each value into a new one, and `select` keeps only the values for which a closure returns `true`:

```inko
let numbers = [3, 10, 0, 7]

numbers.iter.map(fn (n) { n * 2 })      # 6, 20, 0, 14
numbers.iter.select(fn (n) { n > 5 })   # 10, 7
```

These methods are _lazy_: they return a new iterator and do no work until something asks for its values. That
means you can chain them freely, and only one pass is made over the data:

```inko
numbers.iter.select(fn (n) { n > 0 }).map(fn (n) { n * 100 })
```

## Getting a result

To get something out of an iterator, finish it with a method that consumes it:

```inko
numbers.iter.map(fn (n) { n * 2 }).to_array # => [6, 20, 0, 14]
numbers.iter.select(fn (n) { n > 5 }).count # => 2
numbers.iter.any?(fn (n) { n == 0 })        # => true
numbers.iter.all?(fn (n) { n >= 0 })        # => true
numbers.iter.find(fn (n) { n > 5 }).or(-1)  # => 10
Int.sum(numbers.iter)                       # => 20
```

`reduce` is the general tool: it starts with an initial value (the _accumulator_) and calls the closure with the
accumulator and each value in turn, keeping whatever the closure returns as the new accumulator:

```inko
numbers.iter.reduce(0, fn (sum, n) { sum + n })      # => 20
numbers.iter.reduce(0, fn (best, n) { if n > best { n } else { best } }) # => 10
```

An iterator can only be used once. Once `count` or `to_array` has taken its values, it's empty; call `iter` again
for a new one.

## Indexes, pairs and slices

`with_index` pairs every value with its position, as a tuple `(index, value)`:

```inko
let words = ['bee', 'wasp', 'ant']

words.iter.with_index.map(fn (pair) { '${pair.0}: ${pair.1}' }).to_array
# => ['0: bee', '1: wasp', '2: ant']
```

`zip` walks two iterators side by side, making pairs until either runs out. `skip(n)` leaves out the first `n`
values and `take(n)` stops after `n`:

```inko
let a = [1, 2, 3]
let b = [10, 20, 30]

a.iter.zip(b.iter).map(fn (pair) { pair.0 + pair.1 }).to_array # => [11, 22, 33]
a.iter.skip(1).to_array                                         # => [2, 3]
a.iter.take(2).to_array                                         # => [1, 2]
```

Zipping an iterator with the same values skipped by one gives each value next to the one after it, handy for
comparing neighbours.

## Iterators over borrowed values

`numbers.iter` borrows each value; for numbers and strings that is the same as a copy, so the closures above can
use them like any `Int`. As with `for` loops, call `iter` on an array stored in a variable or argument, not on a
temporary array literal.

## Loops or iterators?

Anything an iterator chain does can be written as a loop, and the other way around. Chains are shorter for
transforming and filtering; a loop is often clearer when the body does several things at once.
