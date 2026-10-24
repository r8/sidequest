# Introduction

An immediate word runs while a definition is being compiled.
So far that let it count things or compute literals.
With `postpone` it can do what `if`, `loop` and `;` do: put code into the definition being compiled.
This is how Forth programmers add new syntax to the language, in a few lines of Forth.

## `postpone`

`postpone name`, inside a definition, reads `name` and compiles its _compilation behaviour_ into the current definition, to happen later, when that definition runs.

For an ordinary word that means: when the definition runs, compile a call to `name`.
A macro is then an immediate word that postpones a sequence of ordinary words:

```forth
: cubed ( n -- n*n*n )
  postpone dup  postpone dup  postpone *  postpone * ; immediate

: volume ( side -- v ) cubed ;
```

When `volume` is compiled, `cubed` runs (it is immediate) and compiles `dup dup * *` into `volume`.
`volume` contains no call to `cubed` at all: `see volume` shows the four words.

For an immediate word, `postpone` compiles a call to it, so it will run when the macro runs, in the middle of compiling some other definition.
That is how a macro can use `if`, `then`, `?do` or `loop` on behalf of the definition it is used in:

```forth
: if-negative ( n -- )
  postpone 0<  postpone if ; immediate

: describe ( n -- ) if-negative ." below zero" then ;
```

`if-negative` compiles `0<` and then does what `if` does at compile time: it lays down a conditional branch and leaves its bookkeeping on the stack for the `then` (or `else`) that follows in `describe`.
The new word fits with the existing control words as if it had always been there.

## `literal` in macros

A macro often needs to compile a number.
`literal` is immediate, so writing it in a macro would run it when the _macro_ is compiled; `postpone literal` instead compiles a call that, when the macro runs, takes a number from the stack and compiles it into the definition being built:

```forth
: zero ( -- ) 0 postpone literal ; immediate
: counter-start ( -- n ) zero ;   \ compiled as the literal 0
```

The number can be computed at that moment, from a variable or from the compile-time stack, so each use of the macro may compile a different value.

## `compile,`

`compile, ( xt -- )` compiles a call to the word whose execution token is on the stack.
It is the tool for macros that decide _which_ word to compile while they run, for instance one they read from the source with `'`:

```forth
: thrice ( "name" -- )
  ' dup compile, dup compile, compile, ; immediate

: up-three ( n -- n+3 ) thrice 1+ ;
```

Inside an immediate word, `'` reads the next word from the source being compiled — here `1+` — so the macro consumes it, and `1+` itself is never compiled directly.

## Pitfalls

- **Mark macros `immediate`.** Without it, the macro is compiled as a call and its `postpone`s run every time the definition runs — compiling into whatever definition is current, which is nonsense.
- **Balance control structures.** A macro that does what `if` does must be closed by a `then` in the code that uses it; a macro that compiles both halves (`?do` and `loop`) must be used in matching pairs.
- **The compile-time stack belongs to the compiler.** Control structures keep their bookkeeping on the data stack while compiling; a macro may add to it (as `if` does) or consume it (as `then` does), but must not disturb it otherwise.
- **`postpone` a number?** Numbers are not words; compile them with `postpone literal` as above.
