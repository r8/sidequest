# Introduction

## Words as values

When Forth meets a word, it runs it.
Sometimes you want to talk about a word without running it: to hand it to another word that will decide when to run it, or to keep it in a table.
For that, every word has an _execution token_, or _xt_: a single cell that stands for the word and can be stored, passed and compared like any number.

`'` (tick) reads the next word and pushes its xt instead of running it; `execute ( i*x xt -- j*x )` runs the word an xt stands for:

```forth
: greet ( -- ) ." hello" ;

' greet          \ pushes greet's xt
execute          \ prints hello
```

`execute` has whatever stack effect the word it runs has: `3 ' 1+ execute` leaves 4.

## Tick inside a definition

`'` reads the next word from the input when it runs.
Inside a definition that is the wrong moment, so there it has a compiling cousin, `[']`, which reads the next word while the definition is compiled and compiles its xt as a number:

```forth
: shout ( -- xt ) ['] greet ;   \ shout leaves greet's xt
```

Rule of thumb: `'` at the top level, `[']` inside a colon definition.

## Words that take words

A word that takes an xt can apply someone else's operation to its own data:

```forth
: apply-to-pair ( a b xt -- a' b' )
  tuck execute -rot execute swap ;

3 4 ' negate apply-to-pair   \ leaves -3 -4
```

This is how Forth writes what other languages call higher-order functions: a map over an array, a sort that takes a comparison, an event that runs a handler.

## Words without names

`:noname` starts a definition with no name and, at `;`, leaves the new word's xt on the stack:

```forth
:noname ( n -- n' ) 10 * ;  constant times-ten
5 times-ten execute   \ leaves 50
```

That is handy for operations that are needed in only one place.
(`:noname` is a definition of its own, so it cannot appear inside another colon definition.)

## Tables of xts

Because an xt is a cell, an array of xts is a jump table:

```forth
: add ( a b -- a+b ) + ;
: sub ( a b -- a-b ) - ;
create operations  ' add ,  ' sub ,
: operate ( a b n -- c ) cells operations + @ execute ;

7 2 1 operate   \ leaves 5
```

The table replaces a long chain of `if`s or a `case` that does nothing but choose a word to run.
An xt can equally be kept in a variable and changed while the program runs.

## Pitfalls

- **`'` versus `[']`.** Inside a definition `'` would read the word after the _call_, at run time; use `[']`.
- **Executing a number that is not an xt** jumps somewhere arbitrary and usually crashes gforth.
- **Unbalanced stack effects.** The word an xt stands for must have the stack effect the receiving word expects; `execute` cannot check.
- **Comparing xts** with `=` works (an xt is just a number), which is how you can test which word a table holds.
