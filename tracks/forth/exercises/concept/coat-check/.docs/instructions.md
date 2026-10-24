# Instructions

Ruth runs the coat check at the Grand Theatre.
Every party that hands in its things gets a claim: how many coats and how many bags, written on a ticket as two numbers, coats first.
Between shows, Ruth tallies the claims, and she wants a few words to help.

## 1. Combine two claims

When two parties arrive together, Ruth writes them on one ticket.
Define `combine-claims ( coats1 bags1 coats2 bags2 -- coats bags )`.

```forth
2 1 3 0 combine-claims   \ leaves 5 1
```

## 2. Scale a claim

A school group sends `n` classes, each with the same claim.
Define `scale-claim ( coats bags n -- coats' bags' )`, the claim for all `n` classes.

```forth
20 3 4 scale-claim   \ leaves 80 12
```

## 3. Shift the hooks

At the end of a rail, Ruth keeps four numbered hooks in a row.
When she needs the first hook free, she moves everything one place along: the item on the first hook goes to the last one, and the others move up.
Define `shift-hooks ( a b c d -- b c d a )`.

```forth
1 2 3 4 shift-hooks   \ leaves 2 3 4 1
```

## 4. Find the bigger claim

Ruth puts the bigger of two claims on the larger rail.
The bigger claim is the one with more items in total, coats and bags together; if both have the same number, it is the first.
Define `bigger-claim ( coats1 bags1 coats2 bags2 -- coats bags )`.

```forth
1 1 0 5 bigger-claim   \ leaves 0 5
```
