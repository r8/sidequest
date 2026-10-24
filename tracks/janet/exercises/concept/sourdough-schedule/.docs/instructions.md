# Instructions

Mira runs a tiny bakery that sells one thing: sourdough.
Every loaf follows the same schedule — a few rounds of stretching and folding the dough, then a long rise (the _proof_) before it goes into the oven.
Mira keeps the schedule on a scrap of paper that keeps getting flour on it, so she asks you to write it down as code instead.

## 1. Define the proofing time

Define the constant `proof-minutes`: how many minutes the dough needs to proof.
According to Mira, that is 240 minutes.

```janet
proof-minutes
# => 240
```

## 2. Calculate the remaining proofing time

Define the function `remaining-proof` that takes the number of minutes the dough has already been proofing and returns how many minutes it still needs.

```janet
(remaining-proof 90)
# => 150
```

## 3. Calculate the preparation time

Each round of stretching and folding takes 15 minutes.
Define the function `prep-minutes` that takes the number of rounds and returns how many minutes of preparation they take.

```janet
(prep-minutes 4)
# => 60
```

## 4. Calculate the total working time

Define the function `total-minutes` that takes the number of stretch-and-fold rounds and the number of minutes the dough has been proofing, and returns how many minutes have gone into the loaf so far.

```janet
(total-minutes 3 20)
# => 65
```
