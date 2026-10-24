# Instructions

Olena paints nesting dolls: wooden figures that open in the middle, each holding a smaller one, down to a tiny solid doll that does not open.
Her workshop records each set as data.
A doll is a tuple `[size inner]`, where `size` is its height in millimetres and `inner` is the doll inside it, or `nil` for the solid one at the centre:

```janet
[90 [60 [30 nil]]]   # a set of three: 90 mm, 60 mm and 30 mm
```

Help her with the bookkeeping.

## 1. Count the dolls in a set

Define the function `count-dolls` that takes a doll and returns how many dolls the set has, the outer one included.

```janet
(count-dolls [90 [60 [30 nil]]])
# => 3
```

## 2. Find the smallest doll

Define the function `smallest` that takes a doll and returns the size of the solid doll at the centre.

```janet
(smallest [90 [60 [30 nil]]])
# => 30
```

## 3. List the sizes

Define the function `sizes` that takes a doll and returns a tuple of the sizes in the set, outermost first.

```janet
(sizes [90 [60 [30 nil]]])
# => [90 60 30]
```

## 4. Put a set together

Olena carves the dolls first and assembles them later.
Define the function `nest` that takes a tuple of sizes, outermost first, and returns the assembled set, or `nil` when there are no sizes.

```janet
(nest [90 60 30])
# => [90 [60 [30 nil]]]
```

## 5. Check that a set closes

A set only closes when every doll is strictly smaller than the one around it.
Define the function `closes?` that takes a doll and returns `true` when the set closes and `false` otherwise.

```janet
(closes? [90 [60 [30 nil]]])
# => true

(closes? [90 [95 [30 nil]]])
# => false
```
