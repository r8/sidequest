# Hints

## General

- The manual's [memory management][memory] page explains ownership and moves; its [methods][methods] page covers
  `fn move` methods and closures.

## 1. Take the baton

- A runner may or may not hold a baton: an `Option[Baton]` field, assignable with `let mut`.

## 2. Pass it on

- Swap the baton out of the field with `:=`, leaving `Option.None` behind, then match on what you got.
- `take` on the other runner moves the baton into it.

## 3. Check the colours

- Inside an `fn` method, matching on the field gives a borrow of the baton, which is all you need to read its team.

## 4. Finish the race

- An `fn move` method owns `self`, so it can return a field as it is.

## 5. Count the laps

- The closure must assign a captured variable, so it must be an `fn move` closure.

[memory]: https://docs.inko-lang.org/manual/latest/getting-started/memory-management/
[methods]: https://docs.inko-lang.org/manual/latest/getting-started/methods/
