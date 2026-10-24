# Introduction

`case` chooses among many values of a _selector_ on top of the stack:

```forth
: grade ( n -- points )
  case
    1 of 10 endof
    2 of  6 endof
    0 swap          \ default: result under the selector
  endcase ;
```

Each `of` compares the selector with the value pushed before it; on a match it drops both and runs its branch up to `endof`, then continues after `endcase`.
Words after the last `endof` are the default, which runs with the selector still on the stack; `endcase` drops it, so a default leaves its result _under_ the selector (`… swap`).
`case` tests only equality; ranges need comparisons and `if`.
