# Introduction

A recursive word solves a problem by solving a smaller copy of it first.
While a word is being defined its name is hidden, so it calls itself with `recurse`:

```forth
: sum-to ( n -- sum )
  dup 0= if exit then
  dup 1- recurse + ;
```

Every recursive word has a **base case**, answered directly, and a **recursive case**, which makes the problem smaller, calls `recurse`, and combines the result with what it kept on the stack.
Each call must leave exactly what the stack effect promises, in every branch, because the calls around it rely on it.
Without a base case the return stack overflows and gforth stops with an error.
