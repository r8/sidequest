# About

## 𝕊 and named headers

`𝕊` in a function block refers to that block's function, whatever name it was defined under (or none). A
header can give it a name of its own, `{Count 𝕩: 𝕩 = 0 ? 0 ; Count 𝕩: 1 + Count 𝕩 - 1}`, which reads better when
blocks are nested: inside an inner block, `𝕊` is the inner function, so the outer one is reached by its name.
The name belongs to the body whose header defines it; a body without that header still has `𝕊`.

## Structure

- Put the base cases first; bodies are tried in order.
- Make sure every recursive call shrinks its argument towards a base case, or the function recurses until the
  stack overflows.
- Use an accumulator when the answer builds up step by step, or when the number of steps is the answer. The
  one-argument body sets the starting value; two-argument bodies with named left arguments only match calls
  with two arguments, so they never catch the initial call.

## Recursion on lists

A header can destructure a list argument and recurse on a new list: `{𝕊 a‿b: … 𝕊 b‿(a + b)}`. Recursing over
the elements of a list one by one is possible with the take and drop primitives of a later lesson, but it is
rarely the BQN way: a fold, a scan or `⍟` (repeat) usually says the same thing in a few characters and runs much
faster, because primitives work on whole arrays at once.

## Recursion on nested data

Recursion is the natural tool for data whose depth is not fixed, such as nested lists: a function calls itself
on each element (with each, `𝕊¨`) until it reaches atoms. The nesting lesson uses this.

## Limits

CBQN has no tail-call elimination. Each call stays on the stack until it returns, and a few thousand levels are
enough to raise "Stack overflow". Recursion is the right tool when the depth grows slowly, as when halving a
number or following Euclid's algorithm; for long counting loops, prefer array primitives.

## Mutual recursion

Two functions can call each other, as long as both are defined before the first call runs: a block may refer
to a name defined later in the enclosing scope.
