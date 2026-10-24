# Hints

## General

- The manual's [operators][operators] guide shows how operators map to the traits in [std.ops][ops]; equality
  and ordering are in [std.cmp][cmp].
- Every amount is stored in copper, so most methods only work with `@copper` and `other.in_copper`.

## 1. Add amounts

- Create a new `Coins` from the sum of both amounts in copper.

## 2. Pay an amount

- The same as adding, with a different operator.

## 3. Buy several of a kind

- The right-hand side is an `Int`.

## 4. Compare amounts for equality

- Compare the amounts in copper.

## 5. Order amounts

- `Int` already has a `cmp` method.

## 6. Write the amount down

- `/` and `%` by 100 and by 10 split the copper amount into coins.

[operators]: https://docs.inko-lang.org/manual/latest/guides/operators/
[ops]: https://docs.inko-lang.org/std/latest/module/std/ops/
[cmp]: https://docs.inko-lang.org/std/latest/module/std/cmp/
