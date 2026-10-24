# Instructions

The island ferry's ticket machine has broken down, and the harbour master has asked you to program its
replacement in BQN. A ticket depends on how many zones of the bay you cross, the boats leave on a fixed
timetable, and the machine has to give change in coins.

## 1. Calculate the fare

An adult ticket costs 2 coins plus 1.5 coins per zone, and a child pays half the adult fare. Write the function
`Fare`. Its left argument is the number of zones and its right argument a list `adults‿children`; return the
total fare for the group.

```bqn
2 Fare 2‿1
# ⇒ 12.5
```

## 2. Give change

The machine only holds 2-coin and 1-coin pieces, and gives as many 2-coin pieces as it can. Write the function
`MakeChange`. Its left argument is the whole number of coins paid and its right argument the whole-number
price; return the list `twos‿ones` of coins to give back.

```bqn
10 MakeChange 5
# ⇒ ⟨2, 1⟩
```

## 3. Check a ticket

A ticket is a list `start‿length`: the minute of the day it becomes valid and how many minutes it stays valid.
Write the function `Valid`. Its left argument is a ticket and its right argument the current minute of the
day; return `1` if the ticket is valid at that minute (from `start` up to, but not including, `start +
length`), else `0`.

```bqn
600‿90 Valid 650
# ⇒ 1
```

## 4. Print the timetable

Boats leave at a first minute of the day and then every so many minutes. Write the function `Departures`. Its
left argument is a list `first‿every` and its right argument how many departures to show; return the list of
their minutes of the day.

```bqn
600‿45 Departures 4
# ⇒ ⟨600, 645, 690, 735⟩
```

## 5. Apply the discounts

A fare can get two discounts, one after the other. Seniors pay half price, then members of the ferry club get
1 coin off, but no fare drops below 0.5 coins. Write the function `Discounted`. It takes a list
`fare‿senior‿member`, the last two `1` or `0`, and returns the fare to pay.

```bqn
Discounted 6‿1‿1
# ⇒ 2
```
