# Introduction

`do ( limit start -- )` … `loop` runs its body with the index going from `start` up to `limit - 1`; `i` pushes the index.

```forth
: sum-to ( n -- sum )
  0 swap 1+ 1 ?do i + loop ;
```

- `?do` skips the loop when start equals limit; `do` would run it (nearly) forever.
- `n +loop` steps by `n`; counting down, the limit is included: `0 10 do i . -1 +loop` prints 10 down to 0.
- `j` is the index of the enclosing loop.
- `leave` ends the loop; `unloop exit` leaves the word from inside it.

Keep a running total on the stack below the loop, and make each pass leave the stack as it found it.
