# Hints

## General

- [Conditional execution](https://gforth.org/manual/Conditional-execution-Tutorial.html) in the Gforth tutorial, and [Selection](https://gforth.org/manual/Selection.html) in the reference.
- [Leaving definitions](https://gforth.org/manual/Leaving-definitions-or-loops-Tutorial.html) explains `exit`.

## 1. Boil the kettle

- The zero case and the other cases differ by whether something is added.
- When there are no cups, the 0 already on the stack is the answer.

## 2. Steep the leaves

- Three outcomes need two decisions: nest one conditional in another, or handle one case first and `exit`.

## 3. Serve at the right temperature

- Each special case replaces the temperature with a fixed value: drop the old one before pushing the new one.
- Keep a copy of the temperature for every comparison that still needs it.

## 4. Write the bill

- Work out the full price first, then decide whether to reduce it.
- `*/` takes 90% of a number without losing precision.
