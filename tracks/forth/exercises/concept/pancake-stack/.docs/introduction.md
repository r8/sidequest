# Introduction

## The data stack

A Forth program is a sequence of _words_ separated by spaces.
Forth reads them left to right and runs each one as it meets it.
Words do not take arguments in parentheses: they take them from the _data stack_, and they leave their results there.

A number is a word too: it pushes itself onto the stack.

```forth
2 3 +
```

`2` pushes 2, `3` pushes 3, and `+` takes the top two numbers and pushes their sum, 5.
The number on top of the stack is the one pushed last.

In gforth's interactive mode, `.` takes the top number off the stack and prints it, and `.s` shows the whole stack without changing it:

```forth
2 3 + .      \ prints 5
10 4 .s      \ prints <2> 10 4
```

Because each word consumes what the words before it left, there is no operator precedence to remember and no parentheses for grouping.
`(2 + 3) * 4` is written `2 3 + 4 *`; `2 + 3 * 4` is `2 3 4 * +` (or `3 4 * 2 +`).

## Defining words

Programs grow by defining new words.
A definition starts with `:` and a name, and ends with `;`:

```forth
: double ( n -- 2n )
  2 * ;

7 double .   \ prints 14
```

Between the name and the `;` is the _body_: the words to run when `double` is used.
Once defined, `double` is a word like any other and can be used in later definitions.
A name can contain any characters except spaces: `half-price`, `ready?` and `2x` are all ordinary names.
Names are not case-sensitive in gforth.

Words must be separated by whitespace: `2 3+` asks for a word named `3+`, and `:double` for one named `:double`.

## Comments and stack effects

`\` comments out the rest of the line.
`( … )` is a comment up to the closing parenthesis; note the space after `(`, because `(` is a word.

By convention every definition starts with a _stack-effect comment_: what the word takes from the stack, `--`, and what it leaves.
`( n -- 2n )` reads "takes a number, leaves twice that number".
The names are only for the reader, but they are the most useful documentation a Forth program has: when a word misbehaves, compare what the stack holds with what the comment promises.

The rightmost name is the top of the stack.
`( width height -- area )` takes the height from the top and the width below it, so it is called as `3 4 area`.

## Arithmetic

Forth's numbers are _cells_: signed integers as wide as the machine word (64 bits in gforth on a modern machine).
The arithmetic words take their operands in the order they are written in ordinary maths:

| Word     | Stack effect             | Meaning                                  |
| -------- | ------------------------ | ---------------------------------------- |
| `+`      | `( a b -- a+b )`         | sum                                      |
| `-`      | `( a b -- a-b )`         | difference: `10 3 -` is 7                |
| `*`      | `( a b -- a*b )`         | product                                  |
| `/`      | `( a b -- a/b )`         | integer quotient: `7 2 /` is 3           |
| `mod`    | `( a b -- a mod b )`     | remainder: `7 2 mod` is 1                |
| `/mod`   | `( a b -- rem quot )`    | both at once: `7 2 /mod` leaves 1 3      |
| `negate` | `( n -- -n )`            | change the sign                          |
| `abs`    | `( n -- abs(n) )`        | absolute value                           |
| `min`    | `( a b -- smaller )`     | the smaller of two                       |
| `max`    | `( a b -- larger )`      | the larger of two                        |
| `1+` `1-` `2*` `2/` | `( n -- n' )` | add one, subtract one, double, halve     |

Integer division drops the fraction: `7 2 /` is 3, not 3.5.
To divide and round _up_, add one less than the divisor first: `7 1 + 2 /`, that is `(7 + 1) / 2`, is 4.
In gforth `/` and `mod` round towards negative infinity for negative numbers, which matters only when signs are mixed.

`*/` `( a b c -- a*b/c )` multiplies and then divides, keeping the intermediate product at double width so it cannot overflow: `1000 3 4 */` is 750.

## Pitfalls

- **Order of operands.** `10 3 -` is 7 and `3 10 -` is -7: the second operand is the one on top.
- **Leftovers.** A word that leaves an extra number, or consumes one too many, breaks whatever runs after it.
  The tests check that every word leaves exactly what its stack effect says.
- **Redefining a word** with the same name is allowed; gforth prints `redefined …` and later code uses the new definition.
  Definitions compiled earlier keep using the old one.
