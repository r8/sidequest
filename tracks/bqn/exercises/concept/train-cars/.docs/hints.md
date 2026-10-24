# Hints

## General

- The [take and drop documentation](https://mlochbaum.github.io/BQN/doc/take.html) covers `↑` and `↓`,
  including negative counts and fills.
- [Reverse and rotate](https://mlochbaum.github.io/BQN/doc/reverse.html) and
  [shift functions](https://mlochbaum.github.io/BQN/doc/shift.html) cover `⌽`, `»` and `«`.

## 1. Pick the cars at the front

- One primitive does exactly this.

## 2. Uncouple cars at the back

- Dropping from the back takes a negative count.
- Mind the right-to-left rule when negating the count.

## 3. Turn the train around

- Split the train into the locomotive and the rest, reverse the rest, and join them back together.

## 4. Spin the turntable

- Rotating moves the first elements to the end, just like the turntable.

## 5. Push a car into the siding

- One of the shift functions takes what to shift in as its left argument.

## 6. Fit a train to the platform

- Taking more elements than a list has pads it with zeros.
- Which end does a negative count take from, and where does it put the padding?
