# Introduction

Putting things in order is so common that Janet has a small family of sorting functions in its core library.
They differ in two ways: whether they change the collection you give them or build a new one, and how they decide which of two values comes first.

## Sorting in place: `sort`

`sort` rearranges a mutable collection — an array or a buffer — and returns that same collection.

```janet
(def times @[42 17 30])
(sort times)   # => @[17 30 42]
times          # => @[17 30 42], the array itself has changed
```

Because `sort` mutates, it refuses an immutable tuple: `(sort [3 1 2])` is an error.

## Sorting into a new array: `sorted`

`sorted` leaves its argument alone and returns a new, sorted array.
It accepts any indexed collection, tuples included.

```janet
(def times [42 17 30])
(sorted times) # => @[17 30 42]
times          # => (42 17 30), unchanged
```

Use `sorted` when the caller still needs the original order; use `sort` when you own the array and want to avoid the copy.

## How values are compared

Without further instructions, both functions put a value before another when `<` says it is smaller.
`<` is polymorphic: it works on more than numbers.

- Numbers compare by value, integers and floats alike: `(< 1 1.5)` is `true`.
- Strings and keywords compare byte by byte, so `"apple"` comes before `"banana"`, but every uppercase ASCII letter comes before every lowercase one: `(sorted ["b" "a" "C"])` is `@["C" "a" "b"]`.
- Tuples and arrays compare element by element, like words in a dictionary: `[1 "b"]` comes before `[2 "a"]`, and `[1 "a"]` before `[1 "b"]`.

Values of different types also have an order (all numbers come before all strings, for instance), but it is rarely meaningful; sort collections whose elements are alike.

The function `compare` gives the same answer as a number: `-1`, `0` or `1` when its first argument is smaller, equal or greater.

```janet
(compare 3 7)        # => -1
(compare "b" "a")    # => 1
```

## Choosing the order: a comparator

Both `sort` and `sorted` take an optional second argument, a _comparator_: a function of two values that returns true when the first should come before the second.
`<` is the default; passing `>` sorts from largest to smallest.

```janet
(sorted [42 17 30] >)  # => @[42 30 17]
```

Any function of two arguments will do:

```janet
(defn shorter? [a b] (< (length a) (length b)))
(sorted ["fig" "banana" "kiwi"] shorter?) # => @["fig" "kiwi" "banana"]
```

A comparator must be consistent: if it says `a` comes before `b`, it must not also say `b` comes before `a`.
Using `<=` instead of `<` breaks that rule for equal values.

## Sorting by a key: `sort-by` and `sorted-by`

Often you want to order records by one of their fields.
`sort-by` (in place) and `sorted-by` (new array) take a _key function_ first; they call it on every element and sort by the results with `<`.

```janet
(def fruit [{:name "fig" :price 3} {:name "kiwi" :price 1}])
(sorted-by |($ :price) fruit)
# => @[{:name "kiwi" :price 1} {:name "fig" :price 3}]
```

There is no comparator argument here, so to sort by a key in descending order, make the key itself reverse the order — for a number, negate it:

```janet
(sorted-by |(- ($ :price)) fruit) # the most expensive first
```

And because tuples compare element by element, a key function that returns a tuple sorts by several fields at once: `(fn [f] [(f :price) (f :name)])` orders by price and, among equal prices, by name.

## Ties and stability

Janet's sort is a quicksort and is _not stable_: elements that compare as equal may end up in any order relative to each other.
When the order of ties matters, say how to break them, either in the comparator or with a tuple key.

## Taking the first few and reversing

Two helpers combine well with sorting.
`(take n xs)` returns the first `n` elements (fewer if there are not that many), and `reverse` returns the elements of a collection in the opposite order as a new array.

```janet
(take 2 (sorted [5 3 9 1]))  # => (1 3)
(reverse [1 2 3])            # => @[3 2 1]
```
