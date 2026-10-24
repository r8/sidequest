# Instructions

Grandma Odile is teaching the quilting circle to piece quilts on a grid.
Each quilt is a grid of square patches, numbered by row and column from zero in the top-left corner, and each patch has a fabric colour such as `:red` or `:cream`.
Odile plans her quilts on graph paper; the circle would rather have a few functions that do the counting for them.

A quilt is an array of rows, and each row is an array of colour keywords:

```janet
@[@[:red :cream]
  @[:cream :red]]
```

## 1. Lay out a checkerboard

Define the function `checkerboard` that takes the number of rows and columns and returns a quilt in which the patches alternate between `:light` and `:dark`, starting with `:light` in the top-left corner.

```janet
(checkerboard 2 3)
# => @[@[:light :dark :light]
#      @[:dark :light :dark]]
```

## 2. Find the border patches

The border of a quilt gets a sturdier fabric.
Define the function `border-patches` that takes the number of rows and columns and returns the `[row col]` positions of every patch on the outer edge, in reading order: row by row, left to right.

```janet
(border-patches 3 3)
# => @[[0 0] [0 1] [0 2] [1 0] [1 2] [2 0] [2 1] [2 2]]
```

## 3. Count the fabric

Define the function `fabric-needed` that takes a quilt and returns a table from each colour to the number of patches of that colour.

```janet
(fabric-needed @[@[:red :cream] @[:cream :cream]])
# => @{:red 1 :cream 3}
```

## 4. Number the palette

Odile keeps her colours in a palette, a tuple of keywords, and labels her patterns with the colours' positions in it.
Define the function `palette-index` that takes a palette and returns a table from each colour to its position.

```janet
(palette-index [:red :cream :navy])
# => @{:red 0 :cream 1 :navy 2}
```

## 5. Repeat a strip

For the long edges, a short strip of colours is repeated over and over.
Define the function `repeat-strip` that takes a strip (an indexed collection of colours) and a number of times, and returns one array with the strip repeated that many times.

```janet
(repeat-strip [:red :navy] 3)
# => @[:red :navy :red :navy :red :navy]
```
