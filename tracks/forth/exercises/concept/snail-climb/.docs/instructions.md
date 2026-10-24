# Instructions

Every spring the village of Puddleby holds its snail race up the side of the old well.
Pearl, the organiser, has a stack of numbers to work out before race day, and none of them comes with a known number of steps.

## 1. Paint the race numbers

Every snail gets its race number painted on its shell, one digit at a time.
Define `digit-count ( n -- digits )`, the number of decimal digits in a race number of 0 or more.
The number 0 has one digit.

```forth
4096 digit-count   \ leaves 4
0 digit-count      \ leaves 1
```

## 2. Wait for the trail to dry

A snail's slime trail dries from both ends: every hour, the wet part shrinks to half its length, rounded down.
The course can be reused once the wet part is shorter than `limit` centimetres.
Define `dry-hours ( trail limit -- hours )`, the number of hours to wait.

```forth
40 5 dry-hours   \ leaves 4: 40, 20, 10, 5, then 2
3 5 dry-hours    \ leaves 0
```

## 3. Climb the well

The well is `depth` centimetres deep.
Each day a snail climbs `up` centimetres, and each night, unless it has reached the top, it slips back 1 centimetre.
Define `climb-days ( depth up -- days )`, the day on which the snail reaches the top.
`up` is always at least 2, so every snail gets there in the end.

```forth
10 3 climb-days   \ leaves 5
```

## 4. Plan the feasts

Snails feast on lettuce on the square-numbered days of the season: day 1, day 4, day 9, day 16, and so on.
Define `next-feast-day ( day -- day' )`, the first feast day after the given day.

```forth
5 next-feast-day   \ leaves 9
9 next-feast-day   \ leaves 16
```
