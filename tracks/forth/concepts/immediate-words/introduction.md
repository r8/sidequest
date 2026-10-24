# Introduction

While compiling a definition, Forth adds each word to it instead of running it — unless the word is _immediate_.
Immediate words run during compilation: `;`, `if`, `then`, `(` and `\` are all immediate.
Writing `immediate` after a definition's `;` makes it one of them:

```forth
variable compiled-greetings
: greet ( -- ) 1 compiled-greetings +! ; immediate
: welcome ( -- ) greet greet ." hello" ;   \ greet runs twice now, and is not compiled
```

The variable `state` is non-zero while compiling, so an immediate word can tell where it is used; `-14 throw` is the standard complaint for a compile-only word used while interpreting.
