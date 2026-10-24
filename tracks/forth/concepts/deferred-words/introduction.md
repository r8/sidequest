# Introduction

A deferred word is a named slot for an execution token: calling it executes whatever xt it currently holds.

```forth
defer greeting ( -- )
: hello ( -- ) ." Hello" ;
' hello is greeting
greeting                 \ prints Hello
action-of greeting       \ the xt of hello
```

Words compiled with `greeting` in them follow every later `is`.
`is` and `action-of` read the deferred word's name from the source (at compile time inside a definition); `defer! ( xt xt-deferred -- )` and `defer@ ( xt-deferred -- xt )` take its xt instead.

Deferred words make behaviour replaceable at run time, and they allow forward references: declare a word with `defer`, use it, and fill it in once it can be written — the way to write mutually recursive words.
