# Introduction

A tuple groups a fixed number of values, of any types, into one value. The value and its type are both written
in parentheses:

```koka
val clue : (string, int) = ("paces north", 12)
```

`.fst` and `.snd` give the parts of a pair, but a tuple is usually taken apart by binding names to its parts,
in a `val` or directly in a parameter:

```koka
val (halves, rest) = (3, 1)

fun shift((x, y) : (int, int), dx : int) : (int, int)
  (x + dx, y)
```

Tuples are the simplest way to return several results from one function, and they compare with `==` part by
part.
