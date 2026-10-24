# Hints

## General

- [Functions](https://janet-lang.org/docs/functions.html) in the Janet documentation shows a function calling itself.
- Each task follows the doll's shape: decide what to do with the solid doll (its `inner` is `nil`), then how to handle a doll by combining its own size with the answer for its `inner`.

## 1. Count the dolls in a set

- A doll's `inner` is `(get doll 1)`; test it with `nil?`.
- A set has one doll more than the set inside it.

## 2. Find the smallest doll

- The base case is the doll whose `inner` is `nil`.

## 3. List the sizes

- A tuple can be built with `;` splicing the result of the recursive call into it.

## 4. Put a set together

- Recurse on the sizes: `first` and `(slice sizes 1)` split them into the outer size and the rest.
- Check for `empty?` before slicing.

## 5. Check that a set closes

- A solid doll always closes.
- Otherwise the doll must be bigger than its `inner`, and the `inner` must close too: `and` combines both.
