# Hints

## General

- The [Iter][iter] trait documents every iterator method, with examples.
- Write each answer as a chain starting from `counts.iter`.

## 1. Count all the bees

- `Int.sum` adds up an iterator of integers; `reduce` would work too.

## 2. Count the busy days

- Keep the busy days with `select`, then `count` them.

## 3. Estimate the real numbers

- `map` changes every value; `to_array` collects the result.

## 4. Check for a quiet day

- `any?` stops at the first value for which its closure returns `true`.

## 5. Track the daily changes

- Pair each day with the next one by zipping the counts with the counts minus their first value.

## 6. List the busy days

- `with_index` pairs each count with its position (starting at 0). Select the busy pairs, then map them to day
  numbers.

[iter]: https://docs.inko-lang.org/std/latest/module/std/iter/Iter/
