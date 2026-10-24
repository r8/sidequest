# About

## `[`, `]` and `literal`

- `[` (immediate) sets interpreting state; `]` sets compiling state.
- `literal ( x -- )` (immediate) compiles `x` so that it is pushed at run time; `2literal` and `fliteral` do the same for double cells and floats.
- `]L` (gforth) is `] literal`.

Between `[` and `]` anything can run, including words the program defined earlier, so tables, masks and constants can be derived from other constants without paying at run time.

## Conditional compilation

Interpreting words decide what gets compiled at all:

```forth
[defined] fsqrt [if]
  : root ( F: r -- r' ) fsqrt ;
[else]
  .( no floating point ) cr
[then]
```

`[if] [else] [then]` skip source text according to a flag; `[defined] name` and `[undefined] name` test the dictionary.
They work while interpreting and while compiling, and are the usual way to write code that runs on several Forth systems.

## Compile time versus run time

A Forth program has more than two times: when a file is loaded, when a definition is compiled, when it runs, and, for defining words, when a child word is defined and when it runs.
Getting a value at the wrong time is a common bug: `edition @` inside a definition fetches at run time, `[ edition @ ] literal` at compile time, and `edition @` outside any definition when the line is loaded.

## Constants versus literals

`constant` names a value for reuse; `[ … ] literal` is for a one-off computed value inside one definition.
In gforth both cost the same when they run.
