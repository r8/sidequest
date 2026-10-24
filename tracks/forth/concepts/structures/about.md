# About

## How it works

`begin-structure name` creates `name` and leaves a running offset of 0; each field word reserves room at the current offset (aligned where its type needs it) and defines a word that adds that offset; `end-structure` stores the final offset as the size.
Because a field word is just `( addr -- addr+offset )`, a field at offset 0 costs nothing, and fields compile to a single addition.

| Word | Stack effect while declaring | Field holds |
| --- | --- | --- |
| `field:` | `( u1 "name" -- u2 )` | an aligned cell |
| `cfield:` | `( u1 "name" -- u2 )` | a character |
| `2field:` | `( u1 "name" -- u2 )` | an aligned double |
| `ffield:` `sffield:` `dffield:` | `( u1 "name" -- u2 )` | a float (aligned) |
| `+field` | `( u1 n "name" -- u2 )` | `n` address units, unaligned |

Put `aligned` before a `+field` that holds cells, or declare cell fields first.

## Nesting and arrays

A structure can contain another: `book +field shelf-book` reserves a whole `book` record inside the outer one.
An array inside a record is `10 cells +field scores`, indexed with `i cells +` after the field word.
An array of records is a block of `n * size` units; looping over it is `size +loop` with `bounds`.

## Older styles

gforth 0.7.3 also has its own older `struct … end-struct` with `cell% field name`, which you will meet in older code; `begin-structure` is the Forth 2012 standard and the one to use.
Before structures, Forth programmers defined offsets by hand (`: book-pages cell+ ;`) — still a fine choice for a two-field record.

## Allocating records

- `create name size allot` for a fixed record.
- `size allocate throw` for one on the heap, freed with `free throw`.
- `here size allot` inside a defining word, or `create … does>` to make named instances that return their address.

Records are not cleared on allocation; initialise every field (or `erase` the record) before reading it.
