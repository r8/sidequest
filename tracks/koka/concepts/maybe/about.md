# About

## The type

`maybe<a>` is an ordinary data type with two constructors, defined in the standard library essentially as

```koka
type maybe<a>
  Nothing
  Just(value : a)
```

so everything that works on data types works on it: matching, nested patterns (`Just(Just(x))`), guards
(`Just(n) | n > 0`), and tuples of maybes (`match (a, b)`). A `match` with a `Just(…)` and a `Nothing` branch is
complete.

## Functions on maybes

| Function | Result |
| --- | --- |
| `m.default(x)` | the value of a `Just`, or `x` |
| `m.is-just`, `m.is-nothing` | which case it is |
| `m.map(f)` | `Just(f(x))` for `Just(x)`, `Nothing` stays (a later lesson covers passing functions) |
| `m.maybe(d, f)` | `f(x)` for `Just(x)`, `d` for `Nothing` |
| `m1 \|\| m2` | `m1` if it is a `Just`, else `m2` |
| `m.unjust` | the value, throwing an exception for `Nothing` |

`==`, `cmp` and `show` work on maybes whose values have them: `Just(3) == Just(3)`, `Just(3).show == "Just(3)"`.

## Where they come from

In the standard library, `maybe` is the answer of every lookup that can fail: `xs.head`, `xs.last`, `xs[i]`,
`xs.find(…)`, `s.parse-int`, `s.starts-with(…)`, `v.at(i)` on vectors. The convention is clear: a missing value
that is a normal outcome is a `maybe`; a failure worth an explanation is an `either` or an exception, later
lessons.

## Idioms

- Match when the two cases lead to different work; use `default` when a missing value simply has a stand-in.
- Avoid `unjust` in ordinary code: it turns a `maybe` back into a value by throwing on `Nothing`, which gives up
  the safety the type gave you, and it adds the `exn` effect.
- When a function needs several maybes, matching on a tuple of them keeps the cases flat.
