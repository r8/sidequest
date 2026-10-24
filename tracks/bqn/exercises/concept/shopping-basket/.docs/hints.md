# Hints

## General

- The [fold and insert documentation](https://mlochbaum.github.io/BQN/doc/fold.html) covers `´`, its order and
  its identity values.
- [BQNcrate](https://mlochbaum.github.io/bqncrate/) lists many folds by what they compute.

## 1. Add up the basket

- Put `+` between all the prices.

## 2. Find the priciest item

- Dyadic `⌈` returns the larger of two numbers.

## 3. Check the stock

- First compare every count with `0`, then ask whether all the results are `1`.

## 4. Apply the discounts

- Multiply the discounts together first. What is the product of no numbers at all?

## 5. Print the shopping list

- Fold a block that joins two pieces with `", "` between them.

## 6. Total every basket in an order

- Your answer to task 1, applied to each basket.
