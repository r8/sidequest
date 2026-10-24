# About

`std.range` defines two value types:

| Range | Created with | Includes the end |
| --- | --- | --- |
| `ExclusiveRange` | `start.until(end)` or `ExclusiveRange.new(start, end)` | no |
| `InclusiveRange` | `start.to(end)` or `InclusiveRange.new(start, end)` | yes |

Both are `copy` types (two integers), so creating them is free. Their methods:

- `iter` / `into_iter`: an iterator over the integers, so `for` can loop over a range directly;
- `step_by(amount)`: an iterator that skips `amount - 1` values each step (`0.to(10).step_by(5)` yields 0, 5, 10);
- `size`: the number of values (`0` for an empty range such as `5.until(5)` or `5.to(1)`);
- `contains?(value)`: whether `value` lies in the range;
- `==`, `hash` and formatting.

Since a range is an iterator source, everything from the iterators lesson applies:
`1.to(5).iter.map(fn (n) { n * n }).to_array` is `[1, 4, 9, 16, 25]`.

## Counting down

There are no descending ranges and `step_by` takes positive steps. Count down with `while`, or compute the value
from an ascending index:

```inko
for i in 0.until(size) {
  let index = size - 1 - i
  …
}
```

For arrays, `reverse_iter` walks from last to first.

## times

`Int.times(fn (Int))` calls a closure `n` times with 0 to `n - 1`. It is convenient for side effects such as
`3.times(fn (_) { queue.push(job) })`, but a closure can't assign captured variables, so it isn't suited to
summing.
