# About

## Roles and names

BQN has four syntactic roles, and modifiers are two of them. A 1-modifier (`¨`, `˜`, `⁼`, `_twice`) takes the
operand on its left; a 2-modifier (`∘`, `⊸`, `⌾`, `_then_`) takes one on each side. User-defined names show the
role by their underscores: `_name` for a 1-modifier, `_name_` for a 2-modifier.

## Modifier blocks

A block is a 1-modifier if it mentions `𝔽`, `𝕗` or `_𝕣` but not `𝔾`, `𝕘` or `_𝕣_`, and a 2-modifier if it
mentions any of those. Inside it:

| name | meaning |
| --- | --- |
| `𝔽`, `𝕗` | the left operand, as a function or as a subject |
| `𝔾`, `𝕘` | the right operand, as a function or as a subject |
| `_𝕣`, `_𝕣_` | the modifier itself, for recursion |
| `𝕩`, `𝕨`, `𝕊` | the arguments and the derived function, when the block uses them |

## Deferred and immediate

A modifier block that uses `𝕩` or `𝕨` (or has a header with arguments) is **deferred**: applying it to its
operands gives a function, and the body runs only when that function is called. One that doesn't is
**immediate**: its body runs as soon as it gets its operands, and its value is the result. An immediate
modifier can return a function built from its operands, `_double ← {𝔽∘𝔽}`, or a plain value: `{𝕗+1}` turns
its operand into a number.

## Headers

Modifier headers list the operands with the modifier between them:

```bqn
_scaled ← {𝕗 _𝕣 𝕩: 𝕗 × 𝕩}
_if_ ← {𝔽 _𝕣_ 𝔾 𝕩: 𝔽⍟𝔾 𝕩}
```

Like function headers, they can destructure arguments and have several bodies.

## Operands that are values

An operand is any value. `𝕗` uses it as a subject: `3 _scaled 1‿2` gives `3‿6`. `𝔽` called on a non-function
value returns that value (it is a constant function), which is what makes `2⊸×` work: the `2` is an operand.

## Grouping

Modifiers bind more tightly than function calls, and are applied left to right: `F _m _n` is `(F _m) _n`, and
`F _c_ G _m` is `(F _c_ G) _m`. A right operand of a 2-modifier is a single word unless parenthesised:
`F _then_ (1⊸+)`, not `F _then_ 1⊸+`.

## When to write one

Most code needs no new modifiers: the primitives cover the common patterns. A modifier is worth writing when
the same shape of code is used with different functions, such as a `_keep` that filters by a predicate, or a
`_memo` that caches a function's results.
