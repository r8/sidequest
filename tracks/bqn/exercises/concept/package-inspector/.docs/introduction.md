# Introduction

## When things go wrong

Some mistakes stop a BQN program: adding lists of different lengths, multiplying a character, calling a
function with the wrong kind of argument. Each of these raises an **error**, which has a message:

```bqn
3‿4 + 1‿2‿3    # Error: Mapping: Expected equal shape prefix (⟨2⟩ ≡ ≢𝕨, ⟨3⟩ ≡ ≢𝕩)
'a' × 2        # Error: 𝕨×𝕩: Unexpected argument types
```

An error stops the function it happens in, and the function that called that one, and so on, until something
catches it. If nothing does, the program ends and prints the message.

Not every surprising operation is an error: `4 ÷ 0` is `∞`, and `¯1 ⋆ 0.5` is `NaN` ("not a number"). Checks
for such cases are yours to write.

## Raising your own errors: `!`

`!` is the assertion function. Called with one argument, `! cond` does nothing (it returns `cond`) when `cond`
is `1`, and raises an error with the message `"Assertion error"` otherwise. With a left argument, that is the
message:

```bqn
"weight must be positive" ! 5 > 0     # fine, returns 1
"weight must be positive" ! ¯2 > 0    # Error: weight must be positive
```

Read `msg ! cond` as "insist that `cond` holds, or complain with `msg`". Several assertions in a row check
several things, and the first that fails decides the message:

```bqn
CheckAge ← {
  "age must be a whole number" ! 𝕩 = ⌊𝕩
  "age must not be negative" ! 𝕩 ≥ 0
  𝕩
}
```

Since `msg ! 0` always fails, it is also the way to raise an error from one branch of a conditional. That is
what the stubs do: `"implement me" ! 0`.

```bqn
Grade ← {
  𝕩 > 100 ? "score above 100" ! 0 ;
  𝕩 ≥ 50 ? "pass" ;
  "fail"
}
```

The condition must be exactly `1`. A `2`, or a list of ones, counts as failing.

## Catching errors: `⎊`

Catch, `F⎊G`, is a 2-modifier. It calls `F` with the arguments; if `F` finishes, its result is the result. If
`F` raises an error, `G` is called instead, with the same arguments:

```bqn
Half ← {"odd" ! 0 = 2|𝕩 ⋄ 𝕩 ÷ 2}
Half⎊0 10          # 5
Half⎊0 7           # 0: Half failed, so the constant 0 is the result
Half⎊{𝕩 - 1} 7     # 6: the handler is called with the argument
```

Like any operand, `G` can be a value, which is then the result whenever `F` fails.

## The message: `•CurrentError`

Inside the handler, `•CurrentError @` returns the message of the error being handled:

```bqn
Half⎊{𝕊: •CurrentError @} 7     # "odd"
```

`•CurrentError` is a system function: BQN's names starting with `•` give access to things outside the language
itself, like `•Import` and `•Show`. Calling it outside a handler is itself an error.

## Pitfalls

- A function must be called inside `F` for its errors to be caught. `Half⎊0 7` catches; `(Half 7)⎊0` doesn't,
  because `Half 7` runs, and fails, before `⎊` is reached.
- Catching every error hides mistakes too: an error caused by a typo in `F` is caught just the same. Keep `F`
  small, so that only the failure you expect can happen in it.
- The order of assertions is part of a function's behaviour: an input that breaks two rules gets the message
  of the first check.
