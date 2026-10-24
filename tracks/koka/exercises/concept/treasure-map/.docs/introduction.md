# Introduction

## Tuples

A tuple groups a fixed number of values, which may have different types, into one value. It is written with
parentheses and commas, and so is its type:

```koka
val camp : (int, int) = (0, 0)
val clue : (string, int) = ("paces north", 12)
```

Tuples are handy whenever a function needs to return more than one thing:

```koka
fun split-paces(paces : int) : (int, int)
  (paces / 2, paces % 2)
```

The first and second parts of a pair are `.fst` and `.snd`:

```koka
clue.fst        // "paces north"
clue.snd        // 12
```

More often, a tuple is taken apart by binding its parts to names. A `val` can do that:

```koka
val (halves, rest) = split-paces(7)    // halves is 3, rest is 1
```

and so can a parameter, which keeps a function on points short:

```koka
fun shift((x, y) : (int, int), dx : int) : (int, int)
  (x + dx, y)
```

Tuples compare with `==` part by part, so `(1, 2) == (1, 2)` is `True`.

## Matching

`match` compares a value against a list of _patterns_, one per line, and evaluates the branch of the first
pattern that fits:

```koka
fun describe(paces : int) : string
  match paces
    0 -> "you are standing on it"
    1 -> "one step away"
    _ -> "keep walking"
```

A pattern can be a literal number or string, a name, which matches anything and binds it, or `_`, which matches
anything and binds nothing. Strings match exactly, case and all:

```koka
fun greeting(word : string) : string
  match word
    "ahoy" -> "a pirate"
    "hello" -> "a landlubber"
    other -> "someone who says " ++ other
```

### Guards

A pattern can be followed by `|` and a condition, a _guard_. The branch is chosen only when the pattern fits and
the guard is `True`; otherwise matching goes on with the next line:

```koka
fun depth(metres : int) : string
  match metres
    0 -> "on the surface"
    m | m < 0 -> "above ground"
    m | m > 10 -> "deep"
    _ -> "shallow"
```

### Matching tuples

Tuple patterns take a tuple apart, and each part can be any pattern:

```koka
fun where((x, y) : (int, int)) : string
  match (x, y)
    (0, 0) -> "at camp"
    (0, _) -> "on the north–south path"
    (_, 0) -> "on the east–west path"
    _ -> "in the jungle"
```

### Matching lists

A list is either empty, `Nil`, or an element in front of another list, `Cons(head, tail)`. Patterns can say
which, and how long a list is:

```koka
fun summary(xs : list<string>) : string
  match xs
    [] -> "nothing"                         // the same as Nil
    [x] -> "just " ++ x                     // exactly one element
    [x, y] -> x ++ " and " ++ y             // exactly two
    Cons(x, rest) -> x ++ " and " ++ rest.length.show ++ " more"
```

Order matters: the lines are tried from the top, so put specific patterns before general ones.

### Covering every case

When no pattern fits, the program stops with a pattern-match failure. Koka tracks that possibility: a function
whose `match` does not cover every value can fail, and its type must say so. A function declared `: string`
with only

```koka
match n
  0 -> "zero"
```

is rejected because the match is incomplete. End with a `_` (or a name) to handle everything else.

Koka also warns about a pattern name that is never used, such as `x` in `Cons(x, _) -> "something"`: use `_`
for the parts you ignore.
