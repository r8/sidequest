# About

## What can be undone

`F⁼` works when BQN can find an inverse for `F`. That includes:

- arithmetic: `-`, `÷`, `√` (inverse: square), `⋆` (inverse: natural log), `⋆⁼` (inverse: exponential);
- bound arithmetic: `2⊸×`, `-⟜32`, `10⊸⋆` (inverse: logarithm in base 10), `⋆⟜2`;
- compositions: `F∘G` inverts as `G⁼∘F⁼`, and Under, Self and the identity functions invert as expected;
- structural functions: `⌽`, `n⊸⌽`, `⍉`, `<` (inverse: `⊑` of a unit), and a few others;
- `/⁼` on a list of sorted indices, which counts how often each index occurs: `/⁼ 0‿0‿2` is `2‿0‿1`.

Functions that lose information, such as `⌊`, `|` or `≠`, cannot be inverted, and neither can a block unless it
declares an undo header (below). The error is "Inverse not found".

## Undo with two arguments

`w F⁼ x` finds the `y` for which `w F y` is `x`, with `w` held fixed: `2 ⋆⁼ 8` is `3`, `3 -⁼ 10` is `¯7`. This
gives the logarithm in any base: `b ⋆⁼ x`.

## Undo headers

A block can say how to undo it with an extra body whose header uses `𝕊⁼`:

```bqn
Encode ← {𝕊 𝕩: 3 × 10 + 𝕩 ; 𝕊⁼ 𝕩: (𝕩 ÷ 3) - 10}
Encode⁼ 141     # 37
```

## Precision

Inverses of arithmetic are computed in floating point. `10⊸⋆⁼ 1000` is `2.9999999999999996`, so round with
`⌊0.5+…` or compare with a tolerance when an exact whole number matters.

## Undo, Repeat and Under

`F⍟¯1` is `F⁼`, and `F⍟¯n` undoes `F` `n` times. Computational Under, `F⌾G`, is `G⁼∘F∘G`: it relies on
the same inverses.
