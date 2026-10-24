# About

## Structural Under

When `G` is a structural function, one that only moves or selects elements, `F⌾G x` is `x` with `G x`
replaced by `F G x`. The structural functions include:

- `⊑` (one element), `i⊸⊏` (elements at indices), `m⊸/` (elements where a mask is 1);
- `⌽`, `n⊸⌽`, `n⊸↑`, `n⊸↓`, `⍉`, `⥊`, `⊏˘` and other functions that rearrange or take part of an array;
- compositions of these, such as `⊑∘⌽` (the last element) or `1⊸⊑∘⊑` (an element inside the first one).

```bqn
1⊸+⌾(¯1⊸⊑) 1‿2‿3       # ⟨1, 2, 4⟩: the last element
⌽⌾(2⊸↑) "abcde"        # "bacde": reverse the first two
{'-'¨⌾((' '=𝕩)⊸/) 𝕩} "a b c"   # "a-b-c"
```

The part `F` returns must have the same shape as the part it received, and if an index is selected twice,
both copies must be changed to the same value.

## Computational Under

When `G` is not structural but has an inverse, `F⌾G` is `G⁼∘F∘G`, where `G⁼` is the inverse (a later lesson
covers `⁼`). Typical uses:

- `⌊⌾(100⊸×)` rounds down to two decimals, `⌊⌾(÷⟜100)` down to hundreds;
- `+´⌾(2⊸⋆⁼)` multiplies by adding base-2 logarithms (`4‿8` gives `32`); `×˜⌾√ x` is `x` squared;
- `F⌾(-⟜'a')` works on letters as numbers and converts back.

## With two arguments

`w F⌾G x` applies `G` to both arguments, combines with `F`, and puts the result into `x`'s structure:
`1‿2 +⌾(1⊸⊑) 10‿20` is `10‿22`. With a structural `G`, the result always has the shape of `x`.

## Under or replicate

Under never changes how many elements there are; use `/` to drop elements. And when `F` would be applied to
every element anyway, plain `F¨` or a pervasive function is simpler: `⌾` earns its keep when only some
positions change.

## Pitfalls

- `2⊸⊏` selects with an atom index, which returns a unit array (rank 0) instead of a single element; use
  `2⊸⊑`, or a list of indices, `⟨2⟩⊸⊏`.
- `G` must be in parentheses when it is a bound or composed function: `F⌾(m⊸/)`.
- The mask or indices bound in `G` must be a value, not a function of the argument: `F⌾((0⊸<)⊸/)` fails with
  "Inverse not found". Compute the mask inside a block instead: `{F⌾((𝕩>0)⊸/) 𝕩}`.
