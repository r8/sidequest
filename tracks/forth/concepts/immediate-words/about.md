# About

## Interpretation and compilation semantics

Every Forth word has _interpretation semantics_ (what it does when the text interpreter executes it) and _compilation semantics_ (what happens when the interpreter meets it while compiling).
For an ordinary word, the compilation semantics are "append a call to me to the current definition".
For an immediate word they are the same as its interpretation semantics: it runs.

That single switch is the hook for everything the compiler does.
`if`, `else`, `then`, `begin`, `do`, `loop`, `;`, `does>`, `[char]`, `[']`, `s"` and `."` are ordinary Forth words that happen to be immediate, and a program can add its own.

## `state`

`state @` is non-zero while compiling.
Standard programs may read `state` but must change it only with `[`, `]`, `:` and `;` (and friends).
gforth also has `compile-only`, which marks the latest word so the interpreter refuses to interpret it.

## State-smart words

A word that tests `state` to do one thing when interpreted and another when compiled is called _state-smart_.
They are convenient but have a known trap: inside `[ … ]`, or when executed through `execute` or `postpone`, `state` may not say what the word expects.
gforth offers `interpret/compile:` to give a word two separate behaviours instead.

## Uses of immediate words

- Compile-time side effects: counting, recording addresses, checking that a definition is well formed.
- Compiling something other than a call: a literal (`[char]`), a branch (`if`), inline code (with `postpone`, see that concept).
- Reading ahead in the source at compile time: `(`, `\`, `[char]`, `[']`.

## Finding out

`see word` in gforth shows `immediate` after the decompiled definition of an immediate word, and `find` returns 1 rather than -1 for one.
