# Hints

## General

- [The Koka book on dot-selection](https://koka-lang.github.io/koka/doc/book.html#sec-dot) explains `x.f(y)`.
- [The Koka book on optional and named parameters](https://koka-lang.github.io/koka/doc/book.html#sec-default)
  shows default values and named arguments.

## 1. Price the postage

- A default value goes after the parameter's type: `name : type = value`.

## 2. Spot oversized parcels

- A local helper function for the girth can use the parameters of the function it is defined in.

## 3. Work out the full cost

- Pass the express choice on to the function from task 1; a named argument makes it clear which one it is.

## 4. Refund the overpaid

- Compare the payment with the postage from task 1, and keep the result from going below zero with a function
  from the standard library.
