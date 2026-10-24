# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `variable` | `( "name" -- )` | create a cell; `name ( -- addr )` |
| `2variable` | `( "name" -- )` | two cells, for a pair or a double-cell number |
| `@` `!` | `( addr -- x )` `( x addr -- )` | fetch, store |
| `+!` | `( n addr -- )` | add in place |
| `?` | `( addr -- )` | print the cell, `@ .` |
| `on` `off` | `( addr -- )` | gforth: store `true` or `false` |

## An address, not a value

A variable's name pushes an address, the same kind of number as any other cell.
That uniformity is what makes variables powerful (an address can be passed to a word, stored in another cell, or computed), and also what makes mistakes silent: `score 1+` is a valid address one byte further on, and `@` on a number that is not an address reads garbage or crashes with "invalid memory address".

## Initialisation

The standard does not say what a new variable holds.
gforth happens to start it at 0, but a program should store a value before reading one, either right after the declaration (`variable count  0 count !`) or in a reset word that callers use.

## Variables and style

Forth prefers passing data on the stack.
A variable is right for state that outlives a single call — a counter, a buffer's length, a setting — and wrong as a place to dump intermediate results to avoid stack shuffling: that makes words harder to test and impossible to use recursively.
A word that uses a variable should say so in its comment.

## Variables are memory

`variable x` reserves one cell in the dictionary, which is the same memory that `create` and `allot` work with (see the memory concept).
Everything that works on an address works on a variable: `x cell erase`, `x 2@`, passing `x` to another word.
