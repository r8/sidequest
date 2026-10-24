# Instructions

A battered map has turned up in a sea chest, its margins full of a pirate's scribbled clues. The island is laid
out on a grid: the landing camp is at `(0, 0)`, `x` grows to the east and `y` to the north. You are writing a
little program to follow the clues.

## 1. Take a step

Define the `move` function: it takes a position `(x, y)` and a direction — `"north"`, `"south"`, `"east"` or
`"west"` — and returns the position one step away in that direction. Any other word on the map is a smudge:
stay where you are.

```koka
move((2, 3), "north")
// => (2, 4)
```

## 2. Name the region

Define the `region` function: it takes a position and returns where on the island it is:

- `"camp"` at `(0, 0)`,
- `"mountains"` anywhere further north than `y = 5`,
- `"swamp"` anywhere west of camp (`x` below 0) that is not in the mountains,
- `"beach"` everywhere else.

```koka
region((-2, 1))
// => "swamp"
```

## 3. Count the paces

The pirate walked only along the grid lines. Define the `paces` function: it takes two positions and returns
how many single steps it takes to walk from one to the other.

```koka
paces((1, 2), (4, -2))
// => 7
```

## 4. Read the clues aloud

Define the `read-clues` function: it takes the list of clues found so far and returns what the parrot squawks:

- `"No clues!"` when there are none,
- `"Only <clue>!"` when there is one,
- `"<first> then <second>!"` when there are two,
- `"<first> then <n> more!"` when there are more, where `n` is how many come after the first.

```koka
read-clues(["dig", "under the palm", "at noon"])
// => "dig then 2 more!"
```
