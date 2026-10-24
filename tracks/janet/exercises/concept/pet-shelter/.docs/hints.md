# Hints

## General

- [Prototypes](https://janet-lang.org/docs/prototypes.html) and [object-oriented programming](https://janet-lang.org/docs/object_oriented.html) in the Janet documentation explain prototype chains and method calls.
- The [table module](https://janet-lang.org/api/table.html) lists `table/setproto`, `table/getproto` and `table/rawget`.

## 1. Define the pet prototype

- `Pet` is an ordinary table: plain values and functions side by side.
- A method's first parameter is the table it was called on.

## 2. Define the kinds of pet

- `table/setproto` returns the table it was given, so a prototype can be defined and linked in one expression.
- A kind only needs the keys it changes; the rest comes from `Pet`.

## 3. Admit an animal

- Create a fresh table each time, so that two pets never share one.

## 4. Feed the animals

- Edit your definition of `Pet` from the first task.
- `put` changes the pet itself; return `self` at the end.

## 5. Check an animal's kind

- `table/getproto` takes you one step up the chain, and gives `nil` at the top.
- A `while` loop with a `var` can walk the chain; so can a recursive function.
