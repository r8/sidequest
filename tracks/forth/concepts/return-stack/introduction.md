# Introduction

The _return stack_ is where Forth remembers where each word returns to, and a word may borrow it to park values:

```forth
: add-under ( a b n -- a+n b )
  swap >r + r> ;
```

`>r` moves the top of the data stack to the return stack, `r>` moves it back, and `r@` copies it; `2>r`, `2r>` and `2r@` do the same for a pair, and `rdrop` discards.

The rules: give back everything you park before the word ends, on every path through it (including before `exit`); do not park a value before a `do` loop and reach for it inside, because the loop keeps its own data there; and do not use it at the top level.
