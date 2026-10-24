# About

## The head

A head is read left to right as a list of bindings and modifiers:

```janet
(seq [r :range [0 3]          # outer binding
      c :range [0 3]          # inner binding, changes fastest
      :when (not= r c)        # applies to everything to its right, here the body
      :let [d (- c r)]]
  d)
```

A binding's left side may be a destructuring pattern: `[[k v] :pairs t]`, `[[x y] :in points]`.

### Verbs

| verb | object | yields |
| --- | --- | --- |
| `:range` | `[end]`, `[start end]` or `[start end step]` | `start`, `start+step`, … below `end` |
| `:range-to` | the same | … up to and including `end` |
| `:down` | `[start end]` or `[start end step]` | `start`, `start-step`, … above `end` |
| `:down-to` | the same | … down to and including `end` |
| `:in` | any collection, or a fiber | the values (bytes for a string) |
| `:keys` | any collection | the keys; indices for arrays and tuples |
| `:pairs` | any collection | `[key value]` tuples |
| `:iterate` | an expression | the expression's value, re-evaluated each time, until it is `nil` or `false` |

The order of `:in`, `:keys` and `:pairs` over a table or struct is unspecified.
`:in` over a fiber iterates the values the fiber yields, which a later lesson uses.

### Modifiers

- `:when cond` / `:unless cond` — skip the rest for this iteration.
- `:while cond` / `:until cond` — end the binding to the left (and everything inside it) the first time the test fails or succeeds; an outer binding continues with its next value.
- `:let [bindings]` — like `let`, for the rest of the iteration.
- `:before form` / `:after form` — evaluate `form` before or after each iteration of the rest.
- `:repeat n` — run the rest `n` times.

`(break)` in a body ends the innermost binding's loop; the outer bindings carry on with their next values.

## The collecting macros

- `(seq head body)` returns an array of the body's values; a body skipped by `:when` contributes nothing.
- `(tabseq head key-expr value-expr)` returns a table; later keys overwrite earlier ones.
- `(catseq head body)` concatenates the indexed collections the body returns into one array.
- `(generate head body)` returns a fiber that yields each value lazily, the subject of the fibers lesson.

`seq` returns an array even when every value is skipped (`@[]`), and `tabseq` an empty table.

## When to use what

- Use `each` or `for` for one simple loop, and `map`, `filter` and friends when one function per element says it all.
- Use `seq` and `tabseq` when the work has two or more dimensions, needs filtering and naming along the way, or both — the head keeps it flat.
- Use `loop` when the body is a side effect: updating a table, pushing to a buffer, printing.

## Pitfalls

- `:range` excludes its end, `:range-to` includes it.
- A modifier applies only to what follows it; `:when` written before the inner binding filters whole rows.
- `loop` and `for` return `nil`; a value computed in the body is lost unless it is stored somewhere or `seq` collects it.
