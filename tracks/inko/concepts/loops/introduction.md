# Introduction

Inko has three loops:

- `while condition { … }` repeats while the condition is true;
- `loop { … }` repeats until a `break` (or `return`);
- `for value in iterable { … }` takes each value of an iterator in turn: `for name in names.iter { … }`.

`break` leaves the innermost loop and `next` starts its next round. `for` accepts patterns, such as
`for (name, age) in people.iter`. Iterate `iter` on an array held in a variable; `for x in [1, 2].iter` panics
because the temporary array is dropped while still borrowed.
