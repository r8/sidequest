# About

## Kinds of block

What a block is depends on the special names it uses:

| uses | kind |
| --- | --- |
| `𝕩`, `𝕨`, `𝕊`, `𝕏` or `𝕎` | function |
| `𝔽` or `𝕗` (and not `𝔾`) | 1-modifier |
| `𝔾` or `𝕘` | 2-modifier |
| none of them | immediate block: evaluated at once |

An immediate block is handy for computing a value with temporary names: `area ← {w ← 3 ⋄ h ← 4 ⋄ w × h}`.

## Statements and results

Statements are separated by newlines or `⋄`. The block's result is the last statement's value; every other
statement is run for its definitions or effects only. A statement can be split over lines inside brackets or
parentheses.

## Scope

BQN is lexically scoped. A block sees the names defined in the blocks around it, including names defined after
the block is written but before it is called. Each call creates fresh local names, so recursive calls do not
interfere.

- `←` defines a name in the current block; doing so twice in the same block is a "Redefinition" error, caught
  before the program runs.
- `↩` changes the innermost existing name of that spelling, possibly an outer one: a function can keep a
  counter in its surroundings this way. Changing an undefined name is an error.
- `name F↩ x` modifies with a function, and `name F↩` with no right side applies `F` to it alone: `n -↩`
  negates `n`.

## Headers

A header is everything before the first `:` in a block body. For functions:

- `𝕊 𝕩:` or `F 𝕩:` — called with one argument (`F` names the function for recursion).
- `𝕨 𝕊 𝕩:` — called with two, though it also accepts one (`𝕨` is then empty); a named left argument,
  `a 𝕊 𝕩:`, requires two.
- `𝕊 n:` or `a 𝕊 b:` — names the arguments; `𝕩` and `𝕨` still work too.
- `𝕊 a‿b:`, `⟨a, b‿c⟩ 𝕊 x:` — destructure lists: the argument must have the right length, and nested patterns
  must match.
- `𝕊 0:` or `𝕊 "yes":` — a literal matches only that value. With several bodies separated by `;`, the first
  matching one runs; the conditionals lesson uses this.

A header that matches nothing raises "No header matched argument". A plain name alone (`n:`) is not a
function header but a _label_ for an immediate block, so write `𝕊 n:`.

## Destructuring definitions

The same patterns work with `←` and `↩`: `a‿b ← 1‿2`, `⟨x, y‿z⟩ ← ⟨1, 2‿3⟩`, and `a‿b ↩ b‿a` swaps two names.
