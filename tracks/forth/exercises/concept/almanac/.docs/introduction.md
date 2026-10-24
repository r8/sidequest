# Introduction

Forth's text interpreter has two states.
When it is _interpreting_, it executes each word as it reads it.
After `:`, it is _compiling_: instead of executing words, it adds them to the definition being built, until `;` switches it back.
Forth lets a program act during compilation too, and this is what makes it possible to extend the compiler in Forth itself.

## Immediate words

Some words are executed even while compiling: they are _immediate_.
`;` is one — if it were compiled, no definition would ever end — and so are `if`, `then`, `(` and `\`.
They do their work at the moment the definition is compiled: `if` lays down a conditional branch, `(` skips a comment.

Marking a definition `immediate`, right after its `;`, makes it one of them:

```forth
variable compiled-greetings
: greet ( -- ) 1 compiled-greetings +! ; immediate

: welcome ( -- ) greet greet ." hello" ;
compiled-greetings @ .   \ prints 2
welcome                  \ prints hello, and compiled-greetings stays 2
```

`greet` ran twice while `welcome` was being compiled, and nothing of it was compiled into `welcome`: running `welcome` only prints.
An immediate word used outside a definition simply runs, as any word would.

## The state

The variable `state` holds the current state: 0 while interpreting, non-zero while compiling.
An immediate word can test it to behave differently, for example to refuse to be used outside a definition.
The standard code for that complaint is -14, "interpreting a compile-only word".

```forth
: only-inside ( -- )
  state @ 0= if -14 throw then ; immediate
```

## `[` and `]`

`[` switches to interpreting in the middle of a definition, and `]` switches back to compiling.
Whatever is between them runs at compile time:

```forth
: show-state ( -- ) [ state @ . ] ;   \ prints 0 while compiling show-state
```

## `literal`

What `[ … ]` computes is left on the data stack at compile time, which is no use by itself.
`literal ( x -- )` is an immediate word that takes a number from the stack at compile time and compiles it into the definition, so the definition pushes that number when it runs:

```forth
: minutes-per-week ( -- n )
  [ 7 24 * 60 * ] literal ;
```

The multiplication happens once, when `minutes-per-week` is compiled; running it just pushes 10080.
gforth also has `]L`, short for `] literal`: `[ 7 24 * 60 * ]L`.

Compile-time computation is not only about speed.
It also captures a value _as it was at compile time_:

```forth
variable rate  20 rate !
: rate-then ( -- n ) [ rate @ ] literal ;
: rate-now  ( -- n ) rate @ ;
25 rate !
rate-then .  rate-now .   \ prints 20 25
```

## Immediate words you already use

`[char] a` and `['] word` are immediate: they read the next word of the source while compiling and compile its character or execution token as a literal.
`char` and `'` do the same reading but at run time, which is why `char` inside a definition reads from the input when the definition runs, not from the definition's own text.

## Pitfalls

- **`immediate` applies to the latest definition.** Write it straight after `;`.
- **Compile-time stack items.** Anything an immediate word or a `[ … ]` section leaves on the stack stays there during compilation and confuses `;`, which keeps its own bookkeeping on the stack too; use it up with `literal`, or leave nothing.
- **A compiled `@` is not a compile-time `@`.** `edition @` in a definition fetches when the definition runs; `[ edition @ ] literal` fetches when it is compiled.
