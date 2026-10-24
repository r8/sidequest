# Instructions

Pip's juggling troupe is rehearsing a new act on a square stage marked out in a metre grid.
Pip notes everything as numbers, and has asked you for a handful of words to make sense of them.
Each one needs its numbers in a different order from the order Pip writes them down.

## 1. Measure the stage

The stage is square.
Define `stage-area ( side -- area )`, the area of a square stage with sides of the given length.

```forth
6 stage-area   \ leaves 36
```

## 2. Count the balls in hand

Pip writes down how many balls each hand holds.
Define `hands ( left right -- total difference )`: the number of balls in both hands, and how many more the left hand holds than the right (negative when it holds fewer).

```forth
5 3 hands   \ leaves 8 2
```

## 3. Measure a pass

Two jugglers stand at grid points `( x1 y1 )` and `( x2 y2 )` and pass clubs to each other.
Define `squared-distance ( x1 y1 x2 y2 -- d² )`, the square of the distance between them: the square of the difference of the `x`s plus the square of the difference of the `y`s.

```forth
1 2 4 6 squared-distance   \ leaves 25
```

## 4. Find the spread of three throws

Pip times three throws and wants to know how even they were.
Define `spread ( h1 h2 h3 -- spread )`, the highest of the three heights minus the lowest.

```forth
30 45 38 spread   \ leaves 15
```

## 5. Find the middle throw

Define `middle-throw ( h1 h2 h3 -- median )`, the height that is neither the highest nor the lowest of the three (when two are equal, that height).

```forth
30 45 38 middle-throw   \ leaves 38
```
