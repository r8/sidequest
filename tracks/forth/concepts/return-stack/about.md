# About

## The words

| Word | Data stack | Return stack |
| --- | --- | --- |
| `>r` | `( x -- )` | `( -- x )` |
| `r>` | `( -- x )` | `( x -- )` |
| `r@` | `( -- x )` | `( x -- x )` |
| `rdrop` | | `( x -- )` (gforth) |
| `2>r` | `( x1 x2 -- )` | `( -- x1 x2 )` |
| `2r>` | `( -- x1 x2 )` | `( x1 x2 -- )` |
| `2r@` | `( -- x1 x2 )` | `( x1 x2 -- x1 x2 )` |

They are compile-only in gforth: use them inside definitions.

## What else lives there

- **Return addresses.** Calling a word pushes where to continue; `;` and `exit` pop it. A value left behind becomes the "return address", which usually crashes.
- **Loop parameters.** `do` pushes the limit and index; `i` and `j` read them, `unloop` removes them. That is why `exit` from inside a counted loop needs `unloop` and why `i` is not visible in words called from the loop body.
- **Locals.** gforth's locals use a separate locals stack, but other systems put them on the return stack, so portable code does not mix `>r` with locals.

## Idioms

- `>r … r>` around a sequence that should not see the top item.
- `>r … r@ … r@ … r>` (or `rdrop`) for a value used several times.
- `2>r … 2r>` to set a pair aside, such as a string `( c-addr u )`.
- `dup >r … r>` to keep a copy for the end of a word.

## Style

The return stack is a tool for short stretches.
Code that parks two or three values for most of a long definition is hard to follow; factor it into smaller words whose stack effects need no parking.
Comment both stacks when it gets tricky: `\ a b  R: n`.
