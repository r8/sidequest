# Instructions

Rosa writes gamebooks: stories where the reader decides, at every turn, which way the hero goes. To check that
every path through a book makes sense, she wants to run her stories as programs. A story calls `branch()` where
it splits, and goes on with `True` in one world and with `False` in the other. The hero's luck rises and falls
along the way, through `luck()` and `change-luck(delta)`.

The `branch` and `luck` effects are declared in the stub.

## 1. Explore every world

Define `all-endings`: it takes a story and returns its ending in every world, the `True` world before the
`False` one at each branch.

```koka
all-endings { if branch() then "left" else "right" }
// => ["left", "right"]
```

## 2. Keep track of luck

Define `with-luck`: it takes the hero's starting luck and a story, and returns the story's ending paired with the
hero's luck at the end.

```koka
with-luck(3) { change-luck(4); luck() * 2 }
// => (14, 7)
```

## 3. Give every world its own luck

Define `luck-per-world`: it takes the starting luck and a story that branches and uses luck, and returns the
ending of every world paired with that world's final luck. Luck gained in one world is not there in another.

```koka
luck-per-world(0) { if branch() then change-luck(2) else change-luck(-1); luck() }
// => [(2, 2), (-1, -1)]
```

## 4. Share the luck between worlds

Define `shared-luck`: it takes the starting luck and a story, and returns the endings of every world together
with the luck left at the very end, when one luck is shared by all the worlds, explored one after another.

```koka
shared-luck(0) { if branch() then change-luck(2) else change-luck(-1); luck() }
// => ([2, 1], 1)
```

## 5. Follow your luck

Not every reader wants to see every world. Define `follow-luck`: it takes a story and runs it in a single world,
where at each branch the hero goes `True` when their luck is at least 0 and `False` otherwise. The luck is left
to a handler further out.

```koka
with-luck(0) { follow-luck { if branch() then "out" else "home" } }
// => ("out", 0)
```
