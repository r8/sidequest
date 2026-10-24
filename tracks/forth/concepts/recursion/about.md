# About

## `recurse` and hidden names

The standard makes a word's name findable only after `;`, so that `: dup ( … ) … dup … ;` can redefine a word in terms of the old one.
The consequence is `recurse` for self-calls.
gforth also offers `recursive`, written right after the name, which makes the name visible inside its own definition:

```forth
: sum-to ( n -- sum ) recursive
  dup 0= if exit then
  dup 1- sum-to + ;
```

`recurse` is standard and more common.

## Mutual recursion

Two words that call each other cannot both be defined first.
The usual answer is a deferred word (see the deferred-words concept): declare `defer odd?`, define `even?` using it, define the real `odd?` under another name, and `is` it into place.

## Depth

Every call pushes a return address on the return stack, which is a fixed size in gforth (a few tens of thousands of cells by default, set with `--return-stack-size`).
Forth systems do not guarantee tail-call elimination, so a recursion as deep as its argument is large should be a loop instead.

## Shape of the stack

Recursive words read best when the recursive call takes its arguments on top in the same order as the word itself, and everything the current call needs afterwards sits below them.
A typical step is `over swap 1- recurse *` for `( base n -- … )`, which keeps one `base` for the multiplication.
The base case usually has to discard arguments as well as push the answer: `2drop 1`.

## When to recurse

Recursion fits problems defined in terms of themselves: factorials, the Euclidean algorithm, Ackermann's function, walking trees and nested lists, divide-and-conquer sorting.
For a simple count-down a `do … loop` or `begin … until` is clearer and does not risk the return stack.
