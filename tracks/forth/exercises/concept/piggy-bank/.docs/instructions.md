# Instructions

Theo is saving up for a bike, coin by coin, in a piggy bank shaped like a very round pig.
His big sister has promised to help him keep track of it, and she does that in Forth.
All amounts are in cents.

## 1. Name the coins

Define the coins Theo saves as constants: `penny` is 1 cent, `nickel` 5, `dime` 10 and `quarter` 25.

```forth
quarter   \ leaves 25
3 dime *  \ leaves 30
```

## 2. Count the savings

Keep the savings in a variable.
Define `empty-bank ( -- )`, which empties the piggy bank, and `balance ( -- cents )`, the cents in it.

```forth
empty-bank balance   \ leaves 0
```

## 3. Put money in

Define `deposit ( cents -- )`, which adds the cents to the savings.

```forth
empty-bank quarter deposit dime deposit balance   \ leaves 35
```

## 4. Take money out

Sometimes Theo cannot resist an ice cream.
Define `withdraw ( cents -- taken )`: take the cents out of the bank and leave the amount taken; when there is less in the bank than that, take out everything there is.

```forth
empty-bank 100 deposit 30 withdraw balance   \ leaves 30 70
empty-bank 20 deposit 50 withdraw balance    \ leaves 20 0
```

## 5. Set a goal

The bike costs 120 dollars, so the goal starts at 12000 cents, but prices change.
Define the goal as a value named `goal` that starts at 12000, `set-goal ( cents -- )`, which changes it, and `goal-reached? ( -- flag )`, true when the savings are at least the goal.

```forth
goal                                    \ leaves 12000
9500 set-goal  empty-bank 9500 deposit goal-reached?   \ leaves true
```
