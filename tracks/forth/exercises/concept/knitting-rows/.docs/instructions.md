# Instructions

Grandma Ines knits for the whole family, and she counts every stitch.
Her patterns are all about rows: how many stitches each row has, and how many there are in all.
She would like to plan her next projects in Forth.

## 1. Knit a shawl

A triangular shawl starts with a single stitch in the first row, and every row has one more stitch than the row before.
Define `shawl-stitches ( rows -- total )`, the number of stitches in a shawl of that many rows.

```forth
4 shawl-stitches   \ leaves 10
```

## 2. Knit a sleeve

A sleeve starts with `start` stitches in the first row, and every row has two more stitches than the row before.
Define `sleeve-stitches ( rows start -- total )`.

```forth
3 10 sleeve-stitches   \ leaves 36, that is 10 + 12 + 14
```

## 3. Knit a toe

A sock toe starts with `start` stitches and loses `step` stitches every row, until the next row would have no stitches left.
Define `decrease-stitches ( start step -- total )`, the stitches in all the rows of the toe.
`start` and `step` are both at least 1.

```forth
10 3 decrease-stitches   \ leaves 22, that is 10 + 7 + 4 + 1
```

## 4. Use up a ball of yarn

A ball of yarn is good for `yarn` stitches.
Define `rows-from-ball ( yarn start -- rows )`, the number of complete sleeve rows (as in Task 2) Grandma can knit from one ball; she never starts a row she cannot finish.
No ball is ever big enough for more than 100 rows.

```forth
35 10 rows-from-ball   \ leaves 2: 10 + 12 stitches, and 14 more do not fit
```

## 5. Plan a checked blanket

A blanket is a grid of knitted squares, `width` squares wide and `height` squares high, coloured like a chessboard: the corner square is dark, and dark and light alternate along every row and column.
Define `checker-squares ( width height -- dark )`, the number of dark squares.

```forth
3 3 checker-squares   \ leaves 5
```
