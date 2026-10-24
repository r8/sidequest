# Introduction

Floating-point numbers live on their own stack, the float stack; flags, counts and addresses stay on the data stack.
Float literals need an `e`: `1.5e`, `1e`, `2.5e3`. (`1.5` without the `e` is a double-cell integer.)

The float words are the integer ones with an `f` prefix — `f+ f- f* f/ fnegate fabs fsqrt fmin fmax f** fdup fdrop fswap fover frot` — and `pi`, `f.` and `f.s`.
Stack-effect comments show the float stack after `F:`:

```forth
: average ( n -- ) ( F: total -- mean )
  s>f f/ ;
```

`s>f` and `f>s` (which truncates) move numbers between the stacks; `fround` and `floor` round.
`f<`, `f0=` and `f0<` leave their flag on the data stack.
`fconstant`, `fvariable`, `f@` and `f!` name floats.
