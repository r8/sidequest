# Introduction

`postpone name` compiles the compilation behaviour of `name` into the current definition.
In an immediate word, that turns it into a macro which puts code into whatever definition uses it:

```forth
: cubed ( -- ) postpone dup postpone dup postpone * postpone * ; immediate
: volume ( side -- v ) cubed ;          \ compiled as dup dup * *

: unless ( -- ) postpone 0= postpone if ; immediate
: describe ( n -- ) 0< unless ." not negative" then ;
```

Postponing an immediate word such as `if` makes it act when the macro runs, so new control words fit with `then`, `else` and the rest.
`postpone literal` compiles a number computed while compiling; `compile, ( xt -- )` compiles a call to an execution token chosen at that moment.
