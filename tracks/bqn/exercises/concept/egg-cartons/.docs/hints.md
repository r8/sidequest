# Hints

## General

- [Array dimensions](https://mlochbaum.github.io/BQN/doc/shape.html) covers rank, shape and length.
- [Reshape](https://mlochbaum.github.io/BQN/doc/reshape.html) and
  [transpose](https://mlochbaum.github.io/BQN/doc/transpose.html) describe `⥊` and `⍉`.

## 1. Pack a carton

- Reshape takes the shape on the left.

## 2. Measure a tray

- One primitive returns the shape of any array.

## 3. Count the eggs

- The length `≠` of a table counts only its rows. List all the eggs first.

## 4. Unpack a tray

- Reshape with no left argument lists the elements.

## 5. Turn a carton

- Turning rows into columns is a single primitive.

## 6. Fill a crate

- A crate is a reshape too, with a shape of three numbers; the first comes from the left argument.
