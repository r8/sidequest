# Hints

## General

- The [control flow documentation](https://mlochbaum.github.io/BQN/doc/control.html) shows predicates and
  several bodies in use.
- The [blocks documentation](https://mlochbaum.github.io/BQN/doc/block.html) describes headers, predicates and
  how a body is chosen.

## 1. Look up the hourly rate

- A header can hold a string literal: `𝕊 "car": …`.
- Finish with a body that matches any argument.

## 2. Calculate the fee

- Handle the free hour with a predicate, then cap the rest with `⌊`.

## 3. Send vehicles to the right floor

- Chain predicates: one body per floor, the last one without a condition.

## 4. Accept vouchers

- Give the function a body for one argument and bodies for two, with the vouchers as left-argument patterns.
- You can call `Fee` from every body.

## 5. Show the entrance sign

- Work out the free spaces before testing them, or test `capacity` against `occupied` directly.
- Remember that names from one body's header do not exist in the next body.
