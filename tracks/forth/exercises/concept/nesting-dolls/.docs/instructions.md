# Instructions

Grandmother Vera carves nesting dolls: a big wooden doll that opens to reveal a smaller one, which opens to reveal a smaller one still.
Her workshop is busy, and every question her apprentices ask seems to have the same shape as a smaller question.
Answer them with recursive words.

## 1. Count the arrangements

Vera lines finished dolls up on a shelf, and wonders how many different orders she could put them in.
Define `arrangements ( n -- ways )`, the number of ways to line up `n` dolls: one way for no dolls or one doll, and `n` times the arrangements of `n - 1` dolls otherwise.

```forth
3 arrangements   \ leaves 6
```

## 2. Count the layers

Each doll inside another is two thirds of the height of the one around it, rounded down, and a doll under 1 cm tall cannot be carved.
Define `layers ( height -- dolls )`, the number of dolls in a set whose largest doll is `height` cm tall.

```forth
9 layers   \ leaves 5: dolls of 9, 6, 4, 2 and 1 cm
```

## 3. Cut the blocks

Vera buys rectangular boards and cuts them into equal square blocks, as large as possible, with nothing left over.
The side of that square is the largest number that divides both sides of the board: the board's width when its height is 0, and otherwise the same answer for a board of the height and the remainder of the width divided by the height.
Define `largest-square ( width height -- side )`.

```forth
12 8 largest-square   \ leaves 4
```

## 4. Count a family of dolls

For a festival Vera makes a special set in which every doll holds not one but `branching` smaller dolls side by side, down to a given depth.
A set of depth 0 is a single doll; a set of depth `d` is one doll holding `branching` sets of depth `d - 1`.
Define `family-size ( branching depth -- dolls )`, the number of dolls in the set.

```forth
2 2 family-size   \ leaves 7
```
