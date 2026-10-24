# About

## In place or new

| | in place, returns the argument | new array |
| --- | --- | --- |
| by `<` or a comparator | `(sort xs &opt before?)` | `(sorted xs &opt before?)` |
| by a key function | `(sort-by f xs)` | `(sorted-by f xs)` |

The in-place versions need a mutable collection: an array, a buffer (sorting its bytes), or an abstract type with `get`, `put` and `length`.
A tuple is immutable, so `(sort [3 1 2])` is an error; `(sorted [3 1 2])` is fine.
Note that the new versions always return an array, even when given a tuple.

Sorting in place is cheaper, but it changes data the caller may still be holding.
A function that receives a collection and sorts it in place should say so; the convention is a name ending in `!`.

## The default order

`<`, `>`, `<=` and `>=` are polymorphic in Janet:

- numbers by value (`(< 1 1.5)`);
- strings, buffers, symbols and keywords by their bytes, so ASCII uppercase sorts before lowercase and `"10"` before `"9"`;
- tuples and arrays element by element, the shorter first when one is a prefix of the other (`(< [1] [1 0])`);
- values of different types by a fixed order of the types — numbers before strings, for instance — which is consistent but seldom useful.

`compare` returns `-1`, `0` or `1`, and, unlike `<`, first checks whether either value is an object with its own `:compare` method.
`compare<`, `compare>` and friends are variadic versions of the comparison operators built on `compare`, useful as comparators for values that define their own order.

## Comparators

A comparator `(before? a b)` returns true when `a` must come before `b`.
It has to describe a strict order: never true for both `(before? a b)` and `(before? b a)`, and false for equal values.
`<=` is therefore not a valid comparator.

A comparator that looks at several fields:

```janet
(defn before? [a b]
  (if (= (a :score) (b :score))
    (< (a :name) (b :name))
    (> (a :score) (b :score))))
```

## Keys

`sort-by` and `sorted-by` take no comparator: they always compare keys with `<`.
For a descending order by number, negate the key; for several fields, return a tuple:

```janet
(sorted-by |[(- ($ :score)) ($ :name)] players)
```

The key function is called again for each comparison, so an expensive key is worth computing once — for instance by sorting tuples of `[key value]` and taking the values afterwards.

## Stability

`sort` is a quicksort and not stable: equal elements may be reordered.
If the original order of ties matters, include the original index in the key.

## Related functions

- `reverse` returns a new array in the opposite order (a buffer for a string); `reverse!` reverses an array in place.
- `take` and `drop` keep or skip the first `n` elements, which together with a sort gives "the top three".
- `min`, `max`, and `extreme` find one extreme value without sorting everything.
