# About

## Words and the stack

Forth has almost no syntax.
The text interpreter reads the next space-delimited word, looks it up in the dictionary and runs it; if it is not a word, it tries to read it as a number and pushes it.
Everything else — definitions, comments, strings, control structures — is a word that does something special when it runs.

The data stack is where words meet: there are no named parameters (gforth has locals, but idiomatic code rarely needs them).
A word should take only what its stack effect says and leave only what it promises; the tests in this track check that every word leaves the stack balanced.

## Colon definitions

`: name … ;` adds `name` to the dictionary.
`:` reads the name and switches the interpreter into _compiling_ state, where words are compiled into the definition instead of run; `;` ends it.
A definition can use only words defined before it, and redefining a name later does not change definitions that already use the old one.
Names are any run of non-space characters and are case-insensitive in gforth: `ready?`, `>fahrenheit`, `2x` and `half-price` are all common.

## Stack-effect comments

The convention is `( before -- after )`, with the top of the stack on the right.
Common names say what the cells are: `n` a signed number, `u` an unsigned one, `flag`, `c` a character, `addr` an address, `c-addr u` a string, `xt` an execution token, `d` a double-cell number.
Floating-point arguments get their own section: `( F: r1 -- r2 )`.
A word that reads the following word from the source shows it in quotes: `( "name" -- )`.

## Factoring

Forth style favours many short words, each with one job and a few items of stack effect.
A definition longer than a line or two, or one juggling more than three items, is usually a sign that a smaller word is waiting to be named.

## Interactive use

- `.` prints and drops the top cell; `.s` prints the stack non-destructively.
- `see name` decompiles a word.
- `bye` leaves gforth.
