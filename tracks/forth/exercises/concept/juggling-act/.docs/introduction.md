# Introduction

Forth words find their arguments on the data stack, and they find them in a fixed place: the top, or just below it.
Very often the numbers are there, but in the wrong order, or a word needs a number that the next word will also need.
_Stack-shuffling_ words rearrange the top few items so the next word finds what it wants.

## The core shuffles

| Word   | Stack effect              | What it does                               |
| ------ | ------------------------- | ------------------------------------------ |
| `dup`  | `( a -- a a )`            | copy the top item                          |
| `drop` | `( a -- )`                | discard the top item                       |
| `swap` | `( a b -- b a )`          | exchange the top two                       |
| `over` | `( a b -- a b a )`        | copy the second item to the top            |
| `rot`  | `( a b c -- b c a )`      | bring the third item to the top            |
| `-rot` | `( a b c -- c a b )`      | bury the top item under the next two       |
| `nip`  | `( a b -- b )`            | discard the second item                    |
| `tuck` | `( a b -- b a b )`        | copy the top item below the second         |

And the same for pairs of items:

| Word    | Stack effect                       |
| ------- | ---------------------------------- |
| `2dup`  | `( a b -- a b a b )`               |
| `2drop` | `( a b -- )`                       |
| `2swap` | `( a b c d -- c d a b )`           |
| `2over` | `( a b c d -- a b c d a b )`       |

`pick` copies an item from deeper down: `0 pick` is `dup`, `1 pick` is `over`, and `2 pick` copies the third item.
Reaching deeper than that is usually a sign that the word is doing too much.

## Using them

Squaring a number needs it twice, so copy it first:

```forth
: cube ( n -- n*n*n )
  dup dup * * ;
```

To subtract the top from the second you just write `-`; to subtract the second from the top, swap first:

```forth
: from ( a b -- b-a )
  swap - ;

3 10 from .   \ prints 7
```

`over` is the way to keep an argument for later while using it now:

```forth
: plus-percent ( n percent -- n+n*percent/100 )
  over * 100 / + ;

200 15 plus-percent .   \ prints 230
```

Here `over` copies 200 to the top, `*` and `100 /` turn the copy and 15 into 30, and `+` adds it to the 200 still waiting below.

`2dup` keeps a pair while a word consumes it:

```forth
: sum-and-product ( a b -- a+b a*b )
  2dup + -rot * ;
```

After `2dup +` the stack is `a b a+b`; `-rot` tucks the sum under `a b` so that `*` can use them.

## Tracing a definition

The reliable way to write and check a shuffle is to write the stack after every word, as a comment, until it is second nature:

```forth
: sum-and-product ( a b -- a+b a*b )
  2dup   \ a b a b
  +      \ a b s
  -rot   \ s a b
  * ;    \ s p
```

`.s` in gforth shows the same thing interactively.

## Pitfalls

- **`rot` versus `-rot`.** `rot` brings the _deepest_ of three up; `-rot` sends the top _down_. Doing one where you meant the other gives the right numbers in the wrong places, and tests with three different values are the only way to catch it.
- **Order matters for `-` and `/`.** `swap -` and `-` give different answers unless the numbers are equal.
- **Leaving a copy behind.** Every `dup` and `over` adds an item; something must use it up. The tests check that each word leaves exactly what its stack effect says.
- **Too many items.** If a word needs more than three or four items at once, split it into smaller words, each with a simple stack effect.
