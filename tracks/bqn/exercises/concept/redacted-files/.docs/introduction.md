# Introduction

## Changing part of an array

BQN values never change: `-⟜32` applied to a string returns a new string, and the old one is still there. So
how do you change only _some_ elements of a list, say the letters at positions 0 and 6? You could take the
string apart and build a new one, but BQN has a modifier that does it for you: **Under**, `⌾`.

`F⌾G x` works in three steps:

1. apply `G` to `x`, to get a part of it;
2. apply `F` to that part;
3. put the result back where the part came from, leaving everything else in `x` as it was.

```bqn
-⟜32⌾(0‿6⊸⊏) "hello world"    # "Hello World"
```

Here `G` is `0‿6⊸⊏`, which selects the characters at indices 0 and 6. `F` is `-⟜32`, which turns lowercase
letters into capitals. `⌾` puts the two capitals back at indices 0 and 6.

`⌾` is a 2-modifier: `F` is on its left, `G` on its right. Because modifiers group from left to right, `G`
usually needs parentheses when it is a bound function: `F⌾(i⊸⊏)`, not `F⌾i⊸⊏`.

## Which parts

`G` can be any function that picks out elements of its argument without computing new ones. Those you know:

```bqn
10⊸×⌾⊑ 1‿2‿3                 # ⟨10, 2, 3⟩: the first element
0¨⌾(3‿1⊸⊏) 1‿2‿3‿4‿5         # ⟨1, 0, 3, 0, 5⟩: the elements at 3 and 1
-⌾(1‿0‿1‿0⊸/) 1‿2‿3‿4        # ⟨¯1, 2, ¯3, 4⟩: the elements where the mask is 1
```

The mask doesn't have to be a constant. Inside a block, it can be computed from the argument:

```bqn
{-⌾((𝕩>2)⊸/) 𝕩} 0‿5‿1‿7      # ⟨0, ¯5, 1, ¯7⟩: negate everything above 2
```

## The part must keep its shape

Under replaces the part element by element, so `F` must return an array of the same shape as the one it was
given. A common mistake is to return a single value:

```bqn
'█'⌾(1‿0⊸/) "ab"     # Error: 𝔽 must return an array with the same shape as its input
'█'¨⌾(1‿0⊸/) "ab"    # "█b"
```

`'█'¨` replaces each selected character with `'█'`, keeping the length.

## Computational Under

`G` can also be an arithmetic function that BQN knows how to reverse, such as `100⊸×` (whose inverse divides
by 100) or `÷⟜100`. Then `F⌾G x` applies `G`, then `F`, then the inverse of `G`:

```bqn
⌊⌾(100⊸×) 3.14159     # 3.14: scale up, round down, scale back
⌊⌾(÷⟜100) 1234        # 1200: round down to a whole hundred
×˜⌾√ 9                # 81: the square root, squared, then squared back
```

This is the same idea as with the structural functions: do something "in the world of `G`" and come back.

## With two arguments

`w F⌾G x` applies `G` to both arguments, combines the parts with `F`, and puts the result back into `x`:

```bqn
1‿2 +⌾(1⊸⊑) 10‿20     # ⟨10, 22⟩: the elements at index 1 are added
```

## Pitfalls

- With a single index, use `⊑`: `F⌾(2⊸⊑)` changes one element. `2⊸⊏` returns the element wrapped in an
  array, which `F` would have to keep that way.
- The parentheses around `G` are needed whenever `G` is more than one name or primitive.
- Under never changes the length of `x`. To remove elements, use `/` on its own.
