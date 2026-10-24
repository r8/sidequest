# Introduction

## Words that use themselves

A _recursive_ word solves a problem by solving a smaller copy of the same problem first.
The sum of the numbers from 1 to `n` is `n` plus the sum from 1 to `n-1`; the sum from 1 to 0 is 0.

In Forth a definition cannot call itself by name: while a word is being defined its name is hidden, so that a new definition can use the old word of the same name.
To call the word being defined, write `recurse`:

```forth
: sum-to ( n -- sum )
  dup 0= if exit then   \ the sum from 1 to 0 is 0, which is already on the stack
  dup 1- recurse + ;

4 sum-to .   \ prints 10
```

Every recursive word has the same two parts:

- a **base case**, the smallest problem, answered directly without recursing (here `n = 0`);
- a **recursive case**, which makes the problem smaller, calls `recurse`, and combines the answer with what it kept back.

## The stack keeps the work

Each call to `recurse` is an ordinary word call.
The numbers that the current call still needs stay on the data stack underneath, and the return address goes on the return stack, so when the inner call returns its result lands on top of exactly what the outer call left there.
For `4 sum-to` the stack grows like this:

```text
4            \ dup 1-
4 3          \ recurse: dup 1-
4 3 2        \ recurse: dup 1-
4 3 2 1      \ recurse: dup 1-
4 3 2 1 0    \ recurse: base case, exit
4 3 2 1      \ + after each return ...
4 3 3
4 6
10
```

So a recursive word must leave the stack exactly as its stack effect says, in the base case too, or the outer calls will find the wrong numbers.
Write the stack effect first and check each branch against it.

## More than one argument

When a word takes several arguments, the recursive call must receive them in the same order, and anything the outer call needs afterwards has to be kept below them:

```forth
: power ( base exp -- base^exp )
  dup 0= if 2drop 1 exit then
  over swap 1- recurse * ;

2 10 power .   \ prints 1024
```

After `over swap 1-` the stack is `base base exp-1`: one copy of `base` for the multiplication afterwards, and the pair the recursive call expects.

A recursive word can also change its arguments in other ways than counting down: halving a number, taking a remainder, or swapping them around.
What matters is that every call gets closer to the base case.

## Recursion or a loop?

Anything written with `recurse` can be written as a loop, and a loop is usually a little faster.
Recursion reads better when the problem is defined in terms of itself: factorials, greatest common divisors, trees.

## Pitfalls

- **A missing base case** recurses until the return stack overflows; gforth stops with an error such as `Return stack overflow` or, on some systems, `Address alignment exception`.
  The same happens when the recursive case does not get closer to the base case, for example with a negative argument when the base case only checks for zero; checking `dup 1 <` is safer than `dup 0=`.
- **Unbalanced branches.** The base case usually has to drop its arguments and push the answer; forgetting the `drop` leaves an extra item for the caller to trip over.
- **Using the name.** Writing the word's own name instead of `recurse` either fails (`Undefined word`) or, if an older word of that name exists, calls that one instead.
- **Very deep recursion.** gforth's return stack holds some tens of thousands of calls, not millions; recursing once per unit of a large number is a job for a loop.
