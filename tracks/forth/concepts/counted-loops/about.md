# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `do` | `( limit start -- )` | start a loop; always runs the body at least once |
| `?do` | `( limit start -- )` | the same, but skips the loop when `start = limit` |
| `loop` | `( -- )` | add 1 to the index; repeat unless it reached the limit |
| `+loop` | `( n -- )` | add `n`; repeat unless the index crossed the boundary between `limit-1` and `limit` |
| `i` `j` | `( -- n )` | the index of the innermost loop, and of the one around it |
| `leave` | `( -- )` | leave the loop now, continuing after `loop` |
| `unloop` | `( -- )` | discard the loop's parameters, before an `exit` |

## Where the loop keeps its state

`do` moves the limit and the index to the _return stack_ (see the return-stack concept), which is why the data stack is free inside the body and why `exit` needs `unloop` first.
For the same reason, `i` and `j` are only valid in the definition that contains the loop: a word called from the body cannot see them.

## `+loop` boundaries

`+loop` stops when the index crosses the boundary between `limit - 1` and `limit`.
Counting up, the limit is excluded; counting down, the limit itself is still visited:

```forth
10 0 ?do i . 3 +loop    \ 0 3 6 9
0 9 do i . -3 +loop     \ 9 6 3 0
```

A downward loop must use `do`, not `?do`, when start and limit may be equal and that single pass is wanted.

## Idioms

- `n 0 ?do … loop` — do something `n` times.
- `n 1+ 1 ?do … loop` — `i` runs from 1 to `n`.
- `addr len bounds ?do i c@ … loop` — walk through bytes in memory (see the strings concept); `bounds` is `over + swap`.
- `… cell +loop` — walk through cells.
- `i … if leave then` — search; `i … if drop i unloop exit then` — search and return the index.

## Pitfalls

- `0 0 do` loops through every possible index before it stops.
- The body's stack effect must be neutral apart from a deliberate accumulator.
- `leave` jumps immediately; words after it in the body do not run.
- Nested loops need one `unloop` per level before an `exit`.
