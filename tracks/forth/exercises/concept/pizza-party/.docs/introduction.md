# Introduction

## A second stack

Cells hold integers.
For numbers with fractions Forth has _floating-point_ numbers, and they live on a stack of their own: the _floating-point stack_, or float stack.
Float words take their arguments from the float stack and leave their results there, while flags, counts and addresses stay on the data stack.

A float literal is written with an `e`, for "exponent":

```forth
1.5e      \ 1.5
1e        \ 1.0
2.5e3     \ 2500.0
-0.25e    \ -0.25
```

The `e` is required.
`1.5` without it is not a float at all: in Forth a number with a dot in it is a _double-cell integer_, two cells on the data stack.

`f.` prints the top float, and `f.s` shows the whole float stack.

## Arithmetic and shuffling

The float words are the integer ones with an `f` in front:

| Word | Stack effect |
| --- | --- |
| `f+ f- f* f/` | `( F: r1 r2 -- r3 )` |
| `fnegate fabs fsqrt` | `( F: r -- r' )` |
| `fmin fmax` | `( F: r1 r2 -- r3 )` |
| `f**` | `( F: base exponent -- power )` |
| `fdup fdrop fswap fover frot` | the shuffles |
| `pi` | `( F: -- 3.14159… )` |

Stack-effect comments show the float stack separately, after `F:`:

```forth
: hypotenuse ( F: a b -- c )
  fdup f* fswap fdup f* f+ fsqrt ;

3e 4e hypotenuse f.   \ prints 5.
```

A word that uses both stacks gets two comments, data stack first:

```forth
: average ( n -- ) ( F: total -- mean )
  s>f f/ ;

10e 4 average f.   \ prints 2.5
```

## Between the stacks

| Word | Stack effect | |
| --- | --- | --- |
| `s>f` | `( n -- ) ( F: -- r )` | an integer as a float |
| `f>s` | `( -- n ) ( F: r -- )` | drop the fraction, towards zero: `2.7e f>s` is 2, `-2.7e f>s` is -2 |
| `fround` | `( F: r -- r' )` | the nearest whole number (still a float); exact halves go to the even neighbour |
| `floor` | `( F: r -- r' )` | the whole number at or below: `-2.5e floor` is -3 |

There is no word to round upwards in gforth 0.7.3, but rounding `-r` down and negating the result does the same.

Comparisons take floats and leave a flag on the **data** stack, ready for `if` or `and`:

| Word | Stack effect |
| --- | --- |
| `f<` | `( -- flag ) ( F: r1 r2 -- )` |
| `f0= f0<` | `( -- flag ) ( F: r -- )` |

gforth also has `f>`, `f<=` and `f>=`.
Comparing floats for exact equality is rarely a good idea: `0.1e 0.2e f+` is not exactly `0.3e`.

## Named floats

`fconstant` and `fvariable` work like their integer cousins, with `f@` and `f!` to read and write a float variable:

```forth
9.81e fconstant gravity
fvariable speed
3.5e speed f!
speed f@ gravity f* f.
```

## Pitfalls

- **Forgetting the `e`.** `2.5` is a double-cell integer (25 and 0 on the data stack), not two and a half.
- **The wrong stack.** `dup` and `swap` do nothing to floats, and `f+` does nothing to integers. Convert with `s>f` before mixing.
- **Leftover floats.** A word that leaves an extra float, or eats one, breaks the caller just as a data-stack mistake would; the tests check both stacks.
- **`f>s` truncates.** Round first with `fround` or `floor` when the fraction matters.
