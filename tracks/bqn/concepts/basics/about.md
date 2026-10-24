# About

## Numbers

BQN has one number type, a double-precision float. Integers are exact up to 2⋆53. A negative number is
written with the high minus `¯` (`¯3`, `¯0.5`); `-3` is the function `-` applied to `3`, which gives the same
value but is an expression, not a literal. Numbers can be written in scientific notation, `1e6` or `2.5E¯3`,
and `∞`, `¯∞` and `π` are numeric literals.

## Evaluation order

Every function takes everything to its right as its right argument, and the single value to its left as its
left argument. `10 - 3 - 2` is `10 - (3 - 2)`, which is `9`, not `5`. With a left argument, `a F b` groups
`a` with only what is directly to the left of `F`: `2 × 3 + 4` is `2 × (3 + 4)`. A common habit is to write
the part that is computed last on the left, so that no parentheses are needed: `1 + 2 × n` rather than
`(2 × n) + 1`.

## Roles and spelling

BQN's grammar has four roles: subjects (values), functions, 1-modifiers and 2-modifiers. The role of a name
comes from its spelling, not from its value:

| spelling | role | example |
| --- | --- | --- |
| lowercase first letter | subject | `count` |
| uppercase first letter | function | `Count` |
| leading underscore | 1-modifier | `_each` |
| leading and trailing underscore | 2-modifier | `_with_` |

Names ignore case and underscores, so `count`, `Count` and `COUNT` refer to the same variable, used in
different roles. Writing a function's name in lowercase makes it a subject: it can then be put in a list or
passed around, which later lessons use. Writing a number's name with a capital makes it a constant function.

## Blocks

A block `{…}` that refers to `𝕩` or `𝕨` is a function; one that refers to `𝔽` or `𝔾` is a modifier; one that
refers to none of them is evaluated immediately, like parentheses with their own scope. The value of the last
expression is the result. A function block can refer to itself as `𝕊`, and to its arguments in subject role as
`𝕩` and `𝕨` or in function role as `𝕏` and `𝕎`.

A function written with `𝕨` can still be called with only a right argument: `𝕨` is then `·` (nothing), and
using it in arithmetic is an error.

## Definitions

`←` defines a new name in the current scope; defining the same name twice in one scope is an error. `↩`
changes the value of a name that already exists. `⇐` defines and exports a name: a file whose definitions use
`⇐` is a namespace when loaded with `•Import`, and a block using `⇐` returns a namespace.

## Statements

Statements are separated by newlines or by `⋄`. Only the value of the last one is the result of a program or a
block.
