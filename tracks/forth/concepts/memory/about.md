# About

## Address units, cells and characters

Addresses count _address units_, which are bytes on every system you are likely to meet.
`cells ( n -- n' )` and `chars ( n -- n' )` convert counts to address units; `cell+` and `char+` step by one.
In gforth on a 64-bit machine `1 cells` is 8 and `1 chars` is 1, but writing them keeps code portable and says what each number means.

## Fetch and store

| Word | Stack effect | |
| --- | --- | --- |
| `@` `!` | `( addr -- x )` `( x addr -- )` | a cell |
| `c@` `c!` | `( c-addr -- c )` `( c c-addr -- )` | a byte |
| `2@` `2!` | `( addr -- x1 x2 )` `( x1 x2 addr -- )` | two cells (see double-cells) |
| `+!` | `( n addr -- )` | add to a cell |
| `on` `off` | `( addr -- )` | gforth: store true or false |
| `?` | `( addr -- )` | print the cell at an address |

Cells must be read and written at _aligned_ addresses (multiples of the cell size) on many machines.
`create`, `variable` and colon definitions leave `here` aligned; after `c,` or an odd `allot`, write `align` before the next `,`.
`aligned ( addr -- addr' )` rounds an address up.

## The dictionary

`here` points past the last thing compiled.
`allot` moves it forward (or back, with a negative count, to release the most recent allocation); `,` and `c,` store and move.
Dictionary memory is permanent for the life of the program: there is no way to free a piece in the middle.
For memory that comes and goes, use `allocate` and `free` (the heap-memory concept).

`create name` does not reserve anything itself: it records the current `here`, and `name` pushes that address forever after.
`variable name` is `create name 1 cells allot` (gforth also zeroes it), and `create name 0 ,` is a variable with an explicit initial value.

## Block operations

- `erase ( addr u -- )` — `u` bytes of zero.
- `fill ( addr u c -- )` — `u` bytes of `c`; `blank` fills with spaces.
- `move ( from to u -- )` — copy `u` bytes, correct even when the regions overlap.
- `cmove` and `cmove>` copy bytes in a fixed direction, for when the overlap is intended.

## Records and field words

Give every field a word from the record's address to the field's address, such as `: open-flag ( locker -- addr ) 2 cells + ;`.
Then both `@` and `!` use the same name, and changing the layout touches one place.
The structures concept turns this into a declarative layout with `begin-structure` … `end-structure`.

## Safety

Forth does not check addresses.
Storing past the end of a region overwrites whatever comes next — often the next definition's code — and fetching from a bad address throws -9 (invalid memory address) at best.
Keep sizes as named constants and check indices where input is not trusted.
