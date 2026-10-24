# Hints

## General

- [Functions](https://janet-lang.org/docs/functions.html) in the Janet documentation covers `fn` and the `|` shorthand.
- The [core API](https://janet-lang.org/api/index.html) documents `map`, `filter`, `count`, `reduce` and `all`.
- A seed's fields are read by calling the struct with a key: `(seed :days)`.

## 1. List the varieties

- `map` calls a function on every element and collects the results.

## 2. Find the quick growers

- `filter` keeps the elements for which a predicate is truthy.

## 3. Count the varieties of a crop

- `count` takes a predicate, just like `filter`.

## 4. Find the longest wait

- `reduce` carries the longest wait so far from one seed to the next; `max` picks the larger of two numbers.
- The starting value is what an empty catalogue returns.

## 5. Check a catalogue for impatient gardeners

- `all` checks a predicate against every element.
