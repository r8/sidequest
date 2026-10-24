# Introduction

Words take their arguments from fixed places on the data stack, so the items often have to be rearranged first.
The stack-shuffling words do that:

| Word   | Stack effect          |
| ------ | --------------------- |
| `dup`  | `( a -- a a )`        |
| `drop` | `( a -- )`            |
| `swap` | `( a b -- b a )`      |
| `over` | `( a b -- a b a )`    |
| `rot`  | `( a b c -- b c a )`  |
| `-rot` | `( a b c -- c a b )`  |
| `nip`  | `( a b -- b )`        |
| `tuck` | `( a b -- b a b )`    |

`2dup 2drop 2swap 2over` do the same for pairs, and `n pick` copies the item `n` places down.

```forth
: sum-and-product ( a b -- a+b a*b )
  2dup + -rot * ;
```

Trace a definition by writing the stack after each word; keep words short so no more than three or four items are in play.
