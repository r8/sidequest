# Hints

## General

- The core API reference describes [`sort`](https://janet-lang.org/api/index.html#sort), [`sorted`](https://janet-lang.org/api/index.html#sorted), [`sort-by`](https://janet-lang.org/api/index.html#sort-by) and [`sorted-by`](https://janet-lang.org/api/index.html#sorted-by).
- [Comparison](https://janet-lang.org/docs/comparison.html) explains how `<` orders values of different kinds.
- `(doc sorted)` at the REPL shows the arguments each one takes.

## 1. List the scores from best to worst

- The input must stay as it was, so build a new array rather than sorting in place.
- The optional second argument says which of two values comes first.

## 2. List the players alphabetically

- Sort by a key: the function you pass receives one player.

## 3. Show the podium

- A key function cannot take a comparator, but it can turn a high score into a small key.
- `take` copes with collections shorter than the number you ask for.
- Turning players into names is a job for `map`.

## 4. Rank the board in place

- Sorting in place returns the array it was given.
- Either write a comparator that looks at the names when the scores are equal, or use a key that is a tuple of two values.
