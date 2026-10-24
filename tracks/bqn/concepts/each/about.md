# About

## Each as a modifier

`¨` takes one function operand on its left and returns a function. Modifiers bind before functions are applied,
and a 1-modifier's operand is the single word, block or parenthesised expression to its left: in `+´≠¨ x`, `¨`
modifies only `≠`. The result is an ordinary function, so it can be named (`Lengths ← ≠¨`), modified again
(`≠¨¨`), or passed to other modifiers.

## Shapes

Monadic `F¨ x` returns an array of the same shape as `x`, with `F` applied to each element. Each works on arrays of
any rank, not only lists: on a table, it visits every cell element in the table's shape. Called on a single
number or character (an atom), `F¨` returns a rank-0 array holding the result, not the bare result.

Dyadic `w F¨ x` needs `w` and `x` to have matching shapes, or one of them to be an atom or a rank-0 array, which is
then paired with every element of the other. Since a string is a list, a string on one side is paired element by
element; to pair one string with every element, enclose it first: `(<"!") ∾¨ titles`, or refer to it from a
block, `{𝕩 ∾ "!"}¨ titles`.

## Empty arguments

On an empty list, `F¨` never calls `F` and returns an empty list. BQN may need to know the type of the elements
of that empty result (its _fill_); CBQN guesses it, and some code that works on non-empty lists behaves
differently on empty ones. Test the empty case.

## Each and pervasion

Pervasive functions (`+ - × ÷ ⋆ √ ⌊ ⌈ | = ≠ < > ≤ ≥ ∧ ∨ ¬` with two arguments, and the arithmetic ones with one)
already apply to every number or character inside nested lists, at any depth. `F¨` applies `F` exactly one level
down. Use each when a function treats its argument as a whole (`≠`, `∾`, `⌽`, `↑`, blocks), and leave it off
pervasive arithmetic.

Each is the simplest of BQN's mapping modifiers: _table_ `⌜` pairs every element of one array with every element of
the other, and _rank_ `⎉` and _cells_ `˘` map over the rows of a table.
