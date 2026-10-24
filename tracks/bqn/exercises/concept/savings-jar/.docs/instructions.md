# Instructions

Your niece keeps her pocket money in a jar on the kitchen shelf and writes every change on the lid: what she put
in or took out each week, `5` for five coins in and `¯3` for three out. She is saving up for a telescope and would
like to see how she is doing, so you write her a few BQN functions.

## 1. Follow the balance

Write the function `Balances`. It takes the weekly changes and returns how much is in the jar at the end of each
week, starting from an empty jar.

```bqn
Balances 5‿¯2‿10‿¯4
# ⇒ ⟨5, 3, 13, 9⟩
```

## 2. Start from the birthday money

On her birthday the jar was filled with money from her grandparents before any changes were written down. Write
the function `BalancesFrom`. Its left argument is the starting amount and its right argument the changes; it
returns the balance at the end of each week.

```bqn
20 BalancesFrom 5‿¯2‿10
# ⇒ ⟨25, 23, 33⟩
```

## 3. Keep a record

Write the function `Records`. It takes a list of balances and returns, for each week, the highest balance the jar
has held up to and including that week.

```bqn
Records 5‿3‿13‿9
# ⇒ ⟨5, 5, 13, 13⟩
```

## 4. Stay out of debt

Sometimes she borrows from her brother, and the jar goes below zero. Write the function `NeverInDebt`. It takes a
list of balances and returns, for each week, `1` if the balance has not been below zero in that week or any week
before, else `0`.

```bqn
NeverInDebt 5‿0‿¯2‿4
# ⇒ ⟨1, 1, 0, 0⟩
```

## 5. Reach the goal

Write the function `GoalReached`. Its left argument is the price of the telescope and its right argument the
weekly changes; it returns, for each week, `1` if the jar, starting empty, has held at least the price in that week
or any week before, else `0`.

```bqn
10 GoalReached 5‿6‿¯4‿3
# ⇒ ⟨0, 1, 1, 1⟩
```
