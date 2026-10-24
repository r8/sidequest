# Introduction

## Functions that call themselves

BQN has no loop statements. Repeating work is done by applying functions to whole lists, which later lessons
cover, or by _recursion_: a function that calls itself on a smaller problem until the problem is small enough
to answer directly.

Inside a function block, `𝕊` is the function itself. Calling `𝕊` starts a fresh call of the same block, with
its own arguments and local names:

```bqn
Factorial ← {𝕩 ≤ 1 ? 1 ; 𝕩 × 𝕊 𝕩 - 1}
Factorial 5     # 120
```

Read it as two cases. The _base case_, `𝕩 ≤ 1 ? 1`, answers without recursing. The _recursive case_,
`𝕩 × 𝕊 𝕩 - 1`, does a little work and leaves the rest to a call on a smaller argument. Every recursive
function needs both, and every recursive call must move towards the base case; otherwise the calls never
stop.

`𝕊` can be called with one argument or two, like any function. Because it refers to the block it appears in,
it keeps working when the function is renamed or passed around.

## Base cases as headers

The predicates and header patterns of the conditionals lesson both make good base cases. A literal in the
header often reads best:

```bqn
SumTo ← {𝕊 0: 0 ; 𝕊 n: n + 𝕊 n - 1}
SumTo 4         # 10: 4 + 3 + 2 + 1 + 0
```

The bodies are tried in order, so the base case comes first.

## Taking numbers apart

Recursion suits problems that shrink a number step by step. Summing the digits of a number takes the last
digit with `10 |` and the rest with `⌊ 𝕩 ÷ 10`:

```bqn
DigitSum ← {𝕩 < 10 ? 𝕩 ; (10 | 𝕩) + 𝕊 ⌊ 𝕩 ÷ 10}
DigitSum 1234   # 10
```

A function can also recurse on a list argument, destructuring it in the header and building a new list for
the next call:

```bqn
Fib ← {𝕊 n: 0‿1 𝕊 n ; a‿b 𝕊 0: a ; a‿b 𝕊 n: b‿(a + b) 𝕊 n - 1}
Fib 10          # 55
```

## Accumulators

`Fib` shows a common pattern. The one-argument body sets up a starting value and calls the function with two
arguments; the two-argument bodies carry the running result along on the left, the _accumulator_, and return
it when the work is done. The left argument changes on each call while the right one counts down.

Accumulators are also how to count steps until something happens, when the number of steps is not known in
advance:

```bqn
# steps until a number reaches 1 by halving, rounding down
Halvings ← {𝕊 n: 0 𝕊 n ; k 𝕊 1: k ; k 𝕊 n: (k + 1) 𝕊 ⌊ n ÷ 2}
Halvings 20     # 4: 20, 10, 5, 2, 1
```

Remember from the conditionals lesson to put the one-argument body first: a header with a named left
argument, like `k 𝕊 n:`, only matches calls with two arguments.

## Limits

Each pending call takes stack space, and BQN does not turn calls in tail position into loops. CBQN overflows
after a few thousand nested calls ("Stack overflow"), so recursion is for problems whose depth stays small,
such as counting digits or halvings. When a list function can do the job, it is usually both shorter and
faster; the lessons on fold, scan and repeat show the array way to write many of these loops.
