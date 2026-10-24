# Hints

## General

- Koka's own tutorial samples explain [qualified names and overloading](https://github.com/koka-lang/koka/blob/master/samples/learn/qualifiers.kk)
  and [implicit parameters](https://github.com/koka-lang/koka/blob/master/samples/learn/implicits.kk).

## 1. Show an amount of money

- Integer division and remainder by 100 split dollars from cents.
- `pad-left` gives the cents their leading zero.

## 2. Show a measure

- A second `show` in the module needs its own qualifier.

## 3. Compare amounts for equality

- An operator is defined like a function, with its name in parentheses: `fun money/(==)(…)`.

## 4. Order amounts

- `cmp` on two `int`s already returns an `order`.

## 5. Print a tag line

- Declare an implicit `?show` parameter and call `show` on the value.
- Keep the effect variable in the implicit's type, as in the stub, so a `show` with effects is accepted too.

## 6. Find the cheapest

- Declare an implicit `?cmp` parameter.
- `foldl` or recursion over the list works; keep the best so far and replace it only by something strictly smaller.
