# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `begin` | `( -- )` | marks the start of the loop |
| `until` | `( flag -- )` | back to `begin` while the flag is false |
| `while` | `( flag -- )` | continue when true; when false, jump past `repeat` |
| `repeat` | `( -- )` | back to `begin` |
| `again` | `( -- )` | back to `begin`, unconditionally |

All are compile-only.

## Mid-test loops

`while` need not come right after `begin`: everything before it runs on every pass, everything after it only when the test passes.
That gives the "loop and a half" shape without duplicating code:

```forth
begin  next-item  dup valid?  while  process  repeat  drop
```

gforth (and Forth 2012) allows several `while`s in one loop, each matched by a `then` after `repeat`; most code is clearer with `exit` instead.

## `exit` from a loop

Indefinite loops keep nothing on the return stack, so `exit` can leave one directly, with no `unloop`.
That makes `begin … again` with one or more `if … exit then` a clean way to write searches.

## Termination

Make sure something the test depends on changes on every pass.
Common shapes:

- a value moving towards a bound (`10 /`, `2/`, `1-`) tested against it;
- a counter compared with a limit (a counted loop may be clearer);
- a search with a guaranteed hit, plus a safety bound when the guarantee depends on the input.

## Stack shape

Without an index, a counter lives on the stack.
Put it _below_ the values the test looks at, so the test can use `dup` or `2dup` directly; bring it up with `rot` (or keep it on the return stack, see that concept) only when it changes.
Comment the stack at `begin`, at `while`, and at `repeat`.
