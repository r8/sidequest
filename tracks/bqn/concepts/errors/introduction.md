# Introduction

An error stops the running function and every caller, until something catches it.

`msg ! cond` raises an error with the message `msg` unless `cond` is exactly `1`; without `msg` the message is
`"Assertion error"`. `msg ! 0` always raises, which is how one branch of a conditional fails:

```bqn
CheckWeight ← {
  "weight must be positive" ! 𝕩 > 0
  "too heavy" ! 𝕩 ≤ 30
  𝕩
}
```

`F⎊G` calls `F`, and if it raises an error calls `G` with the same arguments instead; `G` may be a plain value.
Inside the handler, `•CurrentError @` is the message:

```bqn
CheckWeight⎊0 31                        # 0
CheckWeight⎊{𝕊: •CurrentError @} 31     # "too heavy"
```
