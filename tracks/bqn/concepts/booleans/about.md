# About

## Booleans are numbers

There is no boolean type: a comparison returns the number `1` or `0`, and any function that wants a truth
value accepts those two numbers. Code that relies on this is idiomatic, not a trick: `count + x > 0` counts
positive values, and `price × ¬ free` charges only those who pay.

## The logic functions

| function | definition | on booleans |
| --- | --- | --- |
| `𝕨 ∧ 𝕩` | `𝕨 × 𝕩` | and |
| `𝕨 ∨ 𝕩` | `(𝕨 + 𝕩) - 𝕨 × 𝕩` | or |
| `¬ 𝕩` | `1 - 𝕩` | not |
| `𝕨 ≠ 𝕩` | not equal | exclusive or |
| `𝕨 = 𝕩` | equal | equivalence |

Because they are arithmetic, they are defined on every number: `0.5 ∧ 0.5` is `0.25`, a probability that
both of two independent events happen. `<` and `>` on booleans give "and not": `a > b` is `a ∧ ¬b`.

BQN has no short-circuiting `and`: both sides of `∧` are always evaluated. When the right side must not run
(it would fail), use a conditional, covered in a later lesson.

## Comparison

`=` `≠` `<` `>` `≤` `≥` compare numbers, and also characters (by code point), which the strings lesson uses.
A number never equals a character, and in ordering every number comes before every character.

Monadic `=`, `≠` and `≢` are unrelated functions (rank, length, shape). `≤` and `≥` have no monadic form.

## Precedence pitfalls

Every function takes all of its right side, so `a < b ∧ c` is `a < (b ∧ c)`. The usual style is to keep the
rightmost condition bare and parenthesise the others: `(a < b) ∧ c < d`. Testing a range is
`(lo ≤ x) ∧ x ≤ hi`.

## Booleans and lists

Once lists appear, comparisons and logic work on whole lists at a time, giving a list of booleans: a
_mask_. Summing a mask counts how many elements matched, and later lessons use masks to filter lists.
