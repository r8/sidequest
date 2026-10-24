# Hints

## General

- The [system values specification](https://mlochbaum.github.io/BQN/spec/system.html) describes `•Fmt`,
  `•Repr` and `•ParseFloat`.
- [Take and Drop](https://mlochbaum.github.io/BQN/doc/take.html) explains how `↑` pads with fills.

## 1. Show a quantity

- Turn the count into text before joining it with the rest.

## 2. Show a price

- Format the whole number of cents first.
- Make sure there are at least three digits, padding with zeros in front, then put the point before the last two.

## 3. Align text to the right

- Taking more elements than there are pads with spaces; a negative count takes from the end.

## 4. Print a receipt line

- The price fills whatever the name leaves of the 20 characters.
- Reuse `Cents` and `PadLeft`.

## 5. Read a price from the shelf label

- `•ParseFloat` reads the text; then convert to cents.
- `100 × 0.29` is not exactly `29` in floating point: round to the nearest whole number.
