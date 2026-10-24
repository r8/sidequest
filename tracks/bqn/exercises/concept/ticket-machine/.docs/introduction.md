# Introduction

## Blocks with several statements

So far every function has been a single expression in braces. A block can hold any number of statements, one
per line or separated by `⋄`. They run in order, and the value of the **last** one is the block's result:

```bqn
Total ← {
  base ← 10
  extra ← 2 × 𝕩
  base + extra
}
Total 4     # 18

Price ← {p ← 𝕩 + 1 ⋄ p × 2}
Price 3     # 8
```

## Local names

A name defined with `←` inside a block is _local_: it exists only while the block runs, and each call gets
its own. A block can also read the names defined around it, and a local name may reuse an outer name, hiding
it inside the block without changing it:

```bqn
rate ← 10
Cost ← {rate × 𝕩}      # reads the outer rate
Cost 3                 # 30

a ← 1
F ← {a ← 2 ⋄ a × 𝕩}    # a new local a
F 5                    # 10
a                      # still 1
```

Inside one block a name can be defined only once: writing `a ← 1` and later `a ← 2` in the same block is an
error ("Redefinition").

## Changing a name

`↩` changes the value of a name that already exists. Combined with a function, `name F↩ value` is short for
`name ↩ name F value`:

```bqn
p ← 3
p ↩ p + 4     # 7
p +↩ 4        # 11
p ×↩ 2        # 22
```

`↩` changes the nearest existing name: inside a block, that is a local one if there is one, otherwise the one
outside. Using `↩` on a name that was never defined is an error. Most BQN code defines new names rather than
changing old ones, but `↩` keeps a step-by-step calculation readable.

## Headers

A block can start with a _header_ that ends in a colon. The header shows how the function is called, and can
give its arguments names:

```bqn
Double ← {𝕊 𝕩: 2 × 𝕩}           # 𝕊 stands for the function itself
Minus ← {𝕨 𝕊 𝕩: 𝕨 - 𝕩}          # called with two arguments
Square ← {𝕊 n: n × n}            # the right argument is named n
Fare ← {zones 𝕊 people: people × 2 + zones}
3 Fare 2                         # 10
```

Named arguments are local names like any other. The stubs in this track use headers such as `{𝕊 𝕩: …}` and
`{𝕨 𝕊 𝕩: …}`; you may keep the header and replace only the body.

## Destructuring

A header can also take a list apart. Where a name would go, a strand of names matches a list of that many
elements and names each one:

```bqn
Area ← {𝕊 w‿h: w × h}
Area 3‿4                     # 12

Inside ← {lo‿hi 𝕊 x: (lo ≤ x) ∧ x ≤ hi}
1‿10 Inside 7                # 1
```

When the argument is not a list of the right length, the call fails with "No header matched argument". The
same pattern works in an ordinary definition:

```bqn
first‿second ← 7‿8
second         # 8
```

## Blocks that run at once

A block that mentions none of `𝕩`, `𝕨` or `𝕊` is not a function: it runs immediately, like parentheses with
their own local names:

```bqn
total ← {b ← 3 ⋄ b × 2}      # total is 6, not a function
```

To write a function that ignores its argument, give it a header: `{𝕊: 42}` is a function, called as `F @`,
where `@` is a conventional "nothing in particular" argument.

On the keyboard, `\;` gives `⋄`, `\'` gives `↩` and `\S` gives `𝕊`.
