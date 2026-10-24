# Instructions

The school's paper-folding club is preparing for its open day. The members want to show off some surprising
facts about paper, and you have been asked to work them out in BQN. Every one of them is a problem that gets a
little smaller each time you fold or cut, so each function is a natural fit for recursion.

## 1. Measure a folded sheet

A sheet of the club's paper is 0.1 millimetres thick, and folding it in half doubles its thickness. Write the
function `Thickness`. It takes the number of folds and returns the thickness in millimetres, calling itself on
one fold fewer.

```bqn
Thickness 3
# ⇒ 0.8
```

## 2. Count the folds to reach a height

Write the function `FoldsToReach`. It takes a height in millimetres and returns the fewest folds that make the
sheet at least that thick.

```bqn
FoldsToReach 1
# ⇒ 4
```

## 3. Find the largest square tile

The club wants to cut a rectangular sheet into equal squares with nothing left over, using squares as large as
possible. The side of that square is the greatest common divisor of the sides: for sides `a‿b`, it is `a` when
`b` is 0, and otherwise the answer for `b‿(b | a)`. Write the function `LargestSquare`. It takes the whole-number
sides `width‿height` and returns that side.

```bqn
LargestSquare 12‿18
# ⇒ 6
```

## 4. Count the squares for origami

For origami each member instead cuts the largest square they can from the sheet, then the largest square from
what is left, and so on until nothing is left. From a sheet whose longer side is `a` and shorter side `b`,
that cuts `⌊ a ÷ b` squares of side `b` and leaves a strip of `b` by `b | a`. Write the function
`CutSquares`. It takes the whole-number sides `long‿short` (with `long ≥ short`) and returns how many squares
are cut in total.

```bqn
CutSquares 5‿3
# ⇒ 4
```

## 5. Name the paper sizes

An A0 sheet is 841 by 1189 millimetres. Folding a sheet across its long side gives the next size: A1 is the
old short side by half the old long side (rounded down to whole millimetres), and so on. Write the function
`PaperSize`. It takes the number of the size (0 for A0) and returns its sides as a list `short‿long`.

```bqn
PaperSize 4
# ⇒ ⟨210, 297⟩
```
