# About

## The count

The right operand of `⍟` is the number of times to apply the left one. It must be a whole number:

- `0` returns the argument as it is;
- a positive `n` applies `F` `n` times;
- a negative `n` applies the inverse `F⁼` that many times, and fails if `F` has none;
- an array of counts returns an array of results of the same shape, each computed as if alone (but in
  practice in one pass: `F⍟(↕n)` applies `F` only `n-1` times).

The operand can be a function `G`, called on the same arguments as `F⍟G` to give the count. With a boolean
result this is a conditional: `F⍟(0⊸<)` applies `F` to a positive number only. On a list, `G` returns a list
of counts and `⍟` returns one result per count, so apply it to each element instead: `2⊸×⍟(0⊸<)¨ ¯3‿4` is
`¯3‿8`.

## With a left argument

`w F⍟n x` keeps `w` fixed and passes it to every application: `w F (w F (… x))`. So `3 +⍟2 10` is `16`. When
the left argument of the call is meant as a count, bind the function first and use the count as the operand
inside a block: `{2⊸×⍟𝕨 𝕩}`.

## Repeat or recursion

Repeat applies the same function a number of times known before it starts. When the number of steps depends
on the values produced (until a list stops changing, until a number reaches 1), write a recursive block that
checks the condition, and use `⍟` with a computed count only for the single conditional step.

## Repeat with lists

Because `⍟` with a list of counts returns every intermediate step, it is a neat way to build sequences:

- `2⊸×⍟(↕n) 1`: the first `n` powers of 2;
- `{(0∾𝕩)+𝕩∾0}⍟(↕n) ⟨1⟩`: the first `n` rows of Pascal's triangle;
- `1⊸⌽⍟(↕≠s) s`: every rotation of `s`.
