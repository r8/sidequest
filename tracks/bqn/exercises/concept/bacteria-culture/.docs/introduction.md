# Introduction

## Repeat `⍟`

Repeat is a 2-modifier: `F⍟n` applies `F` to its argument `n` times.

```bqn
2⊸×⍟3 100        # 800: doubled three times
∾⟜"!"⍟3 "hi"     # "hi!!!"
2⊸×⍟0 7          # 7: applied no times at all
```

The count is the right operand, so a computed count needs parentheses: `F⍟(n-1)`. Inside a block, `F⍟𝕨 𝕩`
applies `F` as many times as the left argument says.

If `F⍟n` is called with a left argument, the left argument is passed to `F` every time: `w F⍟n x` is
`w F (w F (… x))`. Usually it is clearer to bind it yourself, as in `2⊸×⍟3`.

### A list of counts

When the count is a list, `⍟` returns the result for each count, as a list of the same shape:

```bqn
2⊸×⍟(↕4) 100     # ⟨100, 200, 400, 800⟩
⌽⍟(↕3) "ab"      # ⟨"ab", "ba", "ab"⟩
```

This is how you get every step of a repeated process, not only the last one. BQN computes the results in
order and doesn't start over for each count.

### A computed count

The right operand can also be a function. It is called on the arguments to find the count:

```bqn
2⊸×⍟{𝕩<10} 7     # 14: 7 is below 10, so double once
2⊸×⍟{𝕩<10} 70    # 70: no doubling
```

Since a comparison returns `1` or `0`, this is a way to apply a function only when a condition holds.

## Undo `⁼`

`⁼` is a 1-modifier: `F⁼` is the **inverse** of `F`, the function that undoes it. BQN knows the inverses of the
arithmetic functions, and of functions built from them with a bound value:

```bqn
2⊸×⁼ 10          # 5: what doubled gives 10
-⟜32⁼ 0          # 32
√⁼ 3             # 9: the inverse of a square root is a square
⋆⁼ 1             # 0: the natural logarithm
```

With two arguments, `w F⁼ x` answers "which `y` makes `w F y` equal to `x`?":

```bqn
2 ⋆⁼ 16          # 4, because 2 ⋆ 4 is 16: the logarithm in base 2
3 -⁼ 10          # ¯7, because 3 - ¯7 is 10
```

Inverses compose: BQN inverts `F∘G` as "undo `F`, then undo `G`", so a conversion written with combinators can
be reversed for free:

```bqn
Encode ← 3⊸×∘(10⊸+)
Encode 27        # 111
Encode⁼ 111      # 27
```

## Repeating backwards

A negative count repeats the inverse: `F⍟¯1` is `F⁼`, and `F⍟¯2` undoes `F` twice.

```bqn
2⊸×⍟¯2 800       # 200: halved twice
```

## Pitfalls

- BQN cannot invert a block: `{𝕩÷2}⁼ 3` fails with "No monadic undo header found for this block". Write the
  function with combinators, such as `÷⟜2`, when you want to undo it.
- Inverses are computed with floating-point arithmetic, so a logarithm may come out as `2.9999999999999996`
  rather than `3`. Round when you need a whole number.
- Some functions have no inverse at all: `⌊` loses information, so `⌊⁼` is an error.
