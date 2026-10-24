# About

## Getting an xt

| Word | When | Stack effect |
| --- | --- | --- |
| `'` | interpreting | `( "name" -- xt )` |
| `[']` | compiling, immediate | `( "name" -- )`, compiles the xt as a literal |
| `:noname` | interpreting | `( -- xt colon-sys )`, the xt is left after `;` |
| `find-name` + `name>int` | at run time, from a string | `( c-addr u -- nt \| 0 )`, then `( nt -- xt )` (gforth) |

`'` on an unknown word throws -13 (undefined word).
`find` and gforth's `find-name` look a word up from a string at run time, which is how interpreters and command dispatchers are written.

## Using an xt

- `execute ( i*x xt -- j*x )` runs it; the stack effect is the word's own.
- `perform ( addr -- )` (gforth) is `@ execute`: run the xt stored at an address.
- `compile, ( xt -- )` compiles a call to it into the current definition (see the postpone concept).
- `defer` and `is` give an xt a name that can be re-pointed (see the deferred-words concept).

## Idioms

**Higher-order words.** `map`, `filter` and `fold` over arrays take an xt and execute it per element; the xt is usually kept on the stack beside the loop's data, or in a variable when the stack gets crowded.

**Jump tables.** `create table ' a , ' b , ' c ,` and `cells table + @ execute` dispatch on a number in constant time; check the index first, since executing a stray cell crashes the system.

**Callbacks.** A word that reports progress, compares items or handles errors can take an xt for that job and stay general.

## Limitations

- There are no closures: an xt does not capture values. A word that needs data alongside its xt takes the data separately, or uses `create … does>` to bundle them.
- gforth 0.7.3 has no quotations (`[: … ;]`, from later gforth versions and Forth 2012's optional extensions); inside a definition, use a named helper or a `:noname` defined beforehand.
- An xt is valid as long as the word exists; a `marker` or `forget` that removes the word makes it dangle.
