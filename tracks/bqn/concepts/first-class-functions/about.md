# About

## One value, four spellings

A BQN value has no fixed role. The name it is stored under, and how that name is spelled where it is used,
decide how it is treated. `Double`, `double`, `_double` and `_double_` are the same variable; the first calls it,
the second passes it around, and the modifier spellings are for modifiers. An assignment must use the role
of the value's expression: `double ← 2⊸×` and `twice ← {𝔽𝔽𝕩}` are errors, `Double ← 2⊸×` and
`_twice ← {𝔽𝔽𝕩}` are fine.

## Using a value in another role

| value | used as a function | used as a subject |
| --- | --- | --- |
| a function `f` | calls it | the function itself |
| a number or array | returns itself (constant function) | the value |
| a modifier | error | the modifier itself |

Inside blocks, the special names come in both spellings: `𝕩`/`𝕏`, `𝕨`/`𝕎`, `𝕗`/`𝔽`, `𝕘`/`𝔾`, `𝕤`/`𝕊`. So
`{𝕏 3}` calls its argument and `{𝕨 𝕎 𝕩}` calls its left argument on itself and the right one.

## Functions in arrays

Lists of functions work like lists of anything: `⟨+, -, ×⟩` can be selected from, iterated over with
`{𝕏 x}¨`, or zipped with arguments: `⟨-, ⌽⟩ {𝕎 𝕩}¨ ⟨3, "ab"⟩` is `⟨¯3, "ba"⟩`. Functions compare by identity
with `≡`: the same primitive matches itself, but two separately written blocks never match.

## Closures

A block returned from another block keeps access to the names of the call that made it:

```bqn
Counter ← {n ← 𝕩 ⋄ {n + 𝕩}}
add10 ← Counter 10
Add10 5     # 15
```

Each call makes a fresh environment, so `Counter 10` and `Counter 20` give independent functions.

## `•Type`

`•Type x` is `0` for an array, `1` for a number, `2` for a character, `3` for a function, `4` for a 1-modifier,
`5` for a 2-modifier and `6` for a namespace.
