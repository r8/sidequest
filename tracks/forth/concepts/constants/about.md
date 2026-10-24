# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `constant` | `( x "name" -- )` | `name ( -- x )` |
| `2constant` | `( x1 x2 "name" -- )` | a pair or a double-cell number |
| `fconstant` | `( F: r -- ) ( "name" -- )` | a float (see the floats concept) |
| `value` | `( x "name" -- )` | `name ( -- x )`, changeable |
| `to` | `( x "name" -- )` | change a value |

gforth 0.7.3 has no `+to`; write `name 1+ to name`.

## Constant, value or variable?

- **`constant`** for numbers fixed when the program is written: limits, sizes, codes, conversion factors. Naming them documents the code and keeps each number in one place.
- **`value`** for a setting that is read often and replaced as a whole now and then. Reading it looks like reading a constant, which keeps the readers simple.
- **`variable`** for state that is updated in place (`+!`), or whose address must be passed around.

## How they are compiled

A constant's value is fixed when the constant is defined; changing the program text later, or redefining the constant, does not change words compiled earlier.
`to` is a parsing word: it reads the name that follows it in the source, so `to` must be written immediately before the value's name, not computed.

## Naming

Constant names say what the number means, not what it is: `max-guests`, not `twenty`.
Forth code often names codes and enumerations with constants: `0 constant red  1 constant amber  2 constant green`.
