# Hints

## General

- [The `std/core/bool` documentation](https://koka-lang.github.io/koka/doc/std_core_bool.html) lists the
  operations on booleans.
- [The Koka book's section on expressions](https://koka-lang.github.io/koka/doc/book.html#sec-expressions)
  covers `if` and the operators.

## 1. Tell night from day

- The night wraps around midnight, so it is two ranges of hours; one comparison per range is enough.

## 2. Decide who may board

- Group the two ways of being allowed on with parentheses before combining them with the ban.

## 3. Work out the fare

- Check the age groups in an order where the first matching condition is the right one.

## 4. Price the ticket

- An `if` has a value of its own, so it can be added to another number.
