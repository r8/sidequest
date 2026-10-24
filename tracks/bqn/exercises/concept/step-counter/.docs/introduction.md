# Introduction

## Writing lists

A list is written between angle brackets, its elements separated by commas or newlines:

```bqn
⟨1, 2, 3⟩
⟨
  10
  20
⟩
⟨⟩          # the empty list
```

Lists of simple values are so common that BQN has a shorter way to write them: _stranding_. Joining values
with `‿` makes a list of them:

```bqn
1‿2‿3       # the same as ⟨1, 2, 3⟩
¯1‿0.5‿2    # negative numbers and fractions are fine
x ← 5
x‿3         # ⟨5, 3⟩: names can be stranded too
```

`‿` binds more tightly than any function, so `2 × 1‿2‿3` multiplies the whole list. Each part of a strand must
be a single value: to put the result of an expression in a strand, parenthesise it, `(1+1)‿3`, or use the
angle brackets, `⟨1+1, 3⟩`. A list with only one element can only be written with brackets: `⟨3⟩`.

## Length

`≠` with one argument is the length of a list:

```bqn
≠ 4‿5‿6     # 3
≠ ⟨⟩        # 0
```

## Arithmetic works on whole lists

Arithmetic and comparison functions work on lists element by element. A single number paired with a list is
used for every element:

```bqn
1‿2‿3 + 10           # ⟨11, 12, 13⟩
1‿2‿3 × 4‿5‿6        # ⟨4, 10, 18⟩
2‿8‿5 > 4            # ⟨0, 1, 1⟩
24 | 22‿25‿48        # ⟨22, 1, 0⟩
3 ⌈ 1‿5‿2            # ⟨3, 5, 3⟩
⌊ 2.5‿3.7            # ⟨2, 3⟩
```

This is called _pervasion_, and it is why BQN code rarely loops: a function written for one number usually
works on a whole list as it is. `{1 + 2 × 𝕩}` gives `⟨3, 5, 7⟩` when called on `1‿2‿3`.

Two lists combined this way must have the same length; otherwise BQN raises an error:

```bqn
1‿2‿3 + 1‿2          # Error: Mapping: Expected equal shape prefix
```

A comparison of two lists gives a list of booleans, one per position. To ask whether two whole lists are the
same, use `≡` (match), which gives a single `1` or `0`: `1‿2 ≡ 1‿2` is `1`.

## Ranges

`↕ n` is the list of the first `n` natural numbers, starting from zero:

```bqn
↕ 5         # ⟨0, 1, 2, 3, 4⟩
1 + ↕ 5     # ⟨1, 2, 3, 4, 5⟩
2 × ↕ 4     # ⟨0, 2, 4, 6⟩
↕ 0         # ⟨⟩
```

Counting from zero is the rule everywhere in BQN, so adding one is a common step when people expect to count
from one.

## Joining lists

`∾` with two arguments joins lists end to end. A single number on either side is treated as a one-element list:

```bqn
1‿2 ∾ 3‿4‿5     # ⟨1, 2, 3, 4, 5⟩
0 ∾ 1‿2         # ⟨0, 1, 2⟩
1‿2 ∾ 3         # ⟨1, 2, 3⟩
```

## Lists in functions

Functions take and return lists like any other value. Because arithmetic pervades, most of the functions you
write for lists look exactly like ones for numbers:

```bqn
Double ← {2 × 𝕩}
Double 1‿2‿3        # ⟨2, 4, 6⟩
Positions ← {1 + ↕ ≠ 𝕩}
Positions 7‿7‿7     # ⟨1, 2, 3⟩
```

On the keyboard, `\(` and `\)` give `⟨` and `⟩`, the spacebar after `\` gives `‿`, `\d` gives `↕` and `\,`
gives `∾`.
