# Introduction

## Combinators

You have already met one modifier: `¨` takes a function and makes a new one that works on each element. BQN
has a small family of modifiers whose only job is to **combine functions**. They are called combinators, and
they let you build a function out of other functions without writing a block at all.

The ones in this lesson are 2-modifiers: they take an operand on each side, `F∘G`, `F⊸G`, and so on.
Modifiers bind more tightly than function calls, so `F∘G x` is `(F∘G) x`, and they group from left to right:
`F∘G∘H` is `(F∘G)∘H`.

## Atop `∘`

`F∘G` applies `G`, then `F` to the result:

```bqn
⌊∘÷ 4        # ⌊ ÷ 4, which is 0
7 ⌊∘÷ 2      # ⌊ 7 ÷ 2, which is 3
```

With two arguments, both go to `G`; `F` only ever sees one value.

## Over `○`

`F○G` applies `G` to each argument separately, then `F` to the results:

```bqn
"abc" =○≠ "xyz"     # (≠"abc") = ≠"xyz", which is 1
3 +○(×˜) 4           # 9 + 16, which is 25 (×˜ comes below)
```

Called with one argument it is the same as `F∘G`.

## Before `⊸` and After `⟜`

These two treat their arguments unevenly. `F⊸G` applies `F` to the **left** argument first:
`w F⊸G x` is `(F w) G x`. `F⟜G` applies `G` to the **right** argument first: `w F⟜G x` is `w F (G x)`.
The arrow points from the extra function towards the main one:

```bqn
5 -⊸+ 2      # (-5) + 2, which is ¯3
5 +⟜× 2      # 5 + (×2), which is 6: monadic × is the sign
```

Called with only one argument `x`, both use it twice: `F⊸G x` is `(F x) G x`, and `F⟜G x` is `x F (G x)`.

```bqn
√⊸+ 9        # (√9) + 9, which is 12
```

## Binding a value

The most common use of `⊸` and `⟜` is to fix one argument of a function. An operand can be a subject as well
as a function, and a subject used as a function always returns itself, ignoring its arguments. So `2⊸×` is
"2 times", and `-⟜32` is "minus 32":

```bqn
2⊸× 5        # 10
-⟜32 50      # 18
32⊸- 50      # ¯18: 32 - 50, the other way round
```

The number sits on the side of the arrow where it will go: `2⊸×` puts `2` on the left of `×`, `×⟜2` puts it
on the right. Both give the same result for `×`, but not for `-` or `÷`.

Bound functions combine with `∘` into pipelines, read from right to left like everything else:

```bqn
Bonus ← 100⊸+∘(2⊸×)
Bonus 7      # 100 + 2 × 7, which is 114
```

The parentheses around `2⊸×` matter. Without them, `100⊸+∘2⊸×` would group as `((100⊸+)∘2)⊸×`.

## Self and Swap `˜`

`˜` is a 1-modifier, written after its function. Called with one argument, `F˜ x` is `x F x`; called with two,
`w F˜ x` is `x F w`, the arguments swapped:

```bqn
×˜ 7         # 7 × 7, which is 49
2 -˜ 10      # 10 - 2, which is 8
```

## Identity `⊢` and `⊣`

`⊢` returns its right argument and `⊣` its left one; called with one argument, both return it. On their own
they do nothing, but they are useful as operands and, in a later lesson, in trains.

```bqn
3 ⊢ 4        # 4
3 ⊣ 4        # 3
```

## Pitfalls

- A function built with a bound value still has two arguments when called with two: `10 2⊸× 3` is `6`,
  because the constant `2` ignores the `10`.
- Strands bind more tightly than modifiers, so `×⟜2‿3` multiplies by the list `2‿3`.
- These functions are pervasive wherever their parts are: `-⟜32 50‿68` is `18‿36`.
