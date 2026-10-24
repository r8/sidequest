# About

## Assert

`! 𝕩` returns `𝕩` when it is `1` and raises `"Assertion error"` otherwise. `𝕨 ! 𝕩` does the same with the
message `𝕨`. The check is for exactly `1`: `! 2` and `! ⟨1⟩` both fail. The message is usually a string, but can
be any value; `•CurrentError` returns it as given.

Assertions are BQN's way to validate input. Write one per rule, in the order the rules should be checked, at the
top of the block; the first failure wins. Inside a conditional, `msg ! 0` raises from one branch:

```bqn
{𝕩 < 0 ? "negative" ! 0 ; √𝕩}
```

## Catch

`F⎊G` is a 2-modifier. `w F⎊G x` calls `w F x`; if that raises an error, it calls `w G x` instead. Errors
raised inside `G` are not caught by the same `⎊`. Catches nest: an error is caught by the innermost `⎊`
whose `F` it was raised in.

`G` can be a constant (`F⎊0`), a function of the arguments (`F⎊{𝕩 - 1}`), or a block that inspects the error
with `•CurrentError @`. Calling `•CurrentError` outside a handler raises "Not currently within any ⎊".

## Which errors

BQN raises errors for things that cannot be computed: mismatched shapes (`1‿2 + 1‿2‿3`), wrong types
(`'a' × 2`), indices out of range, missing inverses, undefined names at run time. It does not raise for
`÷0` (`∞`) or square roots of negatives (`NaN`); a computation that may produce those should be checked with
an assertion if they are not wanted.

Built-in messages describe the primitive and the problem, like `𝕨×𝕩: Unexpected argument types`. They are
meant for people and may change between versions, so don't compare against them in code; compare against your
own messages instead.

## Errors in this track

The tests check errors with the harness's `t._throws`: `{𝕊: "AB" g.Distance "A"} t._throws "message"` passes
when calling the block raises an error with exactly that message. The stubs raise `"implement me"`.

## Style

BQN code tends to avoid exceptions for control flow: when a failure is an expected outcome, return a value that
says so (an empty list, `0`, a flag) and use `⎊` for the cases you cannot check in advance. Keep the `F` of a
catch small, so that an unrelated mistake isn't swallowed along with the expected error.
