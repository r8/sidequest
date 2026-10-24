# Introduction

## Vectors

A list is built from `Cons` cells, so reaching its hundredth element means walking past the ninety-nine before
it. A _vector_ stores its elements side by side in memory: any element can be read directly by its index, and
its length is known at once. The type `vector<a>` is a vector of elements of type `a`, such as `vector<int>` or
`vector<bool>`.

## Making vectors

There is no literal syntax for vectors. They are made by functions:

```koka
val zeros   = vector(3, 0)                // 0, 0, 0
val squares = vector-init(5, fn(i) i * i) // 0, 1, 4, 9, 16
val digits  = [7, 8, 9].vector            // 7, 8, 9
```

`vector(n, x)` repeats one value `n` times. `vector-init(n, f)` calls `f` with each index from `0` to `n - 1`
and stores the results; like any function that takes a function, it accepts a trailing lambda:

```koka
val prices = vector-init(3) fn(i)
  10 + i * 2                              // 10, 12, 14
```

`.list` turns a vector back into a list. Vectors have no `show` or `==` of their own, so convert them to lists to
print or compare them: `squares.list` is `[0, 1, 4, 9, 16]`.

## Reading elements

Indices start at `0`. `v.length` is the number of elements. There are two ways to read one:

```koka
squares[2]      // 4
squares.at(2)   // Just(4)
squares.at(9)   // Nothing
```

`v.at(i)` returns a `maybe`, `Nothing` when the index is past the end, so it never fails. `v[i]` returns the
element itself, and throws an `index out of bounds` exception when there is none. That possible failure shows in
the type: a function that uses `v[i]` gets the `exn` effect in its result type, just like the stubs that throw
`implement me`:

```koka
fun middle(v : vector<int>) : exn int
  v[v.length / 2]
```

**Pitfall:** Koka 3.2.9 only checks that an index is not too large. A negative index is not caught: `v.at(-1)`
and `v[-1]` read whatever lies in memory before the vector. Check `i >= 0` yourself when an index may be negative.

## Going through a vector

`foreach` calls a function on every element, and `foreach-indexed` passes the index too. With a `var` they
accumulate results, as loops did in the previous lesson:

```koka
fun total(v : vector<int>) : int
  var sum := 0
  v.foreach fn(x)
    sum := sum + x
  sum
```

`v.map(f)` makes a new vector of the results, just like `map` on a list.

## Changing an element

A vector is a value, like a list: no function can change a vector someone else holds. To get a vector with one
element replaced, copy it into a `var` and assign to an index:

```koka
fun with-zero(v : vector<int>, i : int) : exn vector<int>
  var w := v
  w[i] := 0
  w
```

`w[i] := x` replaces the element at `i` in the variable `w`. It throws `index out of bounds` past the end, so it
has the `exn` effect too. The caller's vector is untouched:

```koka
val v = vector(3, 1)
val w = v.with-zero(1)
w.list    // [1, 0, 1]
v.list    // [1, 1, 1]
```

That looks expensive, but Koka counts references to every value at run time. When `with-zero` is given the only
reference to a vector — because the caller does not use it again — the assignment updates it in place, with no
copy at all. Only when the vector is shared does `:=` copy it first.
