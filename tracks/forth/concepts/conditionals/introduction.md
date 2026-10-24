# Introduction

`if` takes a flag from the stack; when it is non-zero, the words up to `then` run, otherwise they are skipped.
`else` adds words for the false case:

```forth
: parity ( n -- 0|1 )
  2 mod 0= if 0 else 1 then ;
```

`if` consumes the flag, so `dup` a number before comparing it if the branch still needs it.
Both branches should leave the stack in the same shape.

`exit` leaves the current word at once, which makes guard clauses: handle a special case, then `exit`.
`?dup` duplicates a number only when it is non-zero, so `?dup if … then` uses the number in the branch and leaves nothing when it is zero.
Conditionals work only inside definitions.
