# Hints

## General

- The [pick documentation](https://mlochbaum.github.io/BQN/doc/pick.html) covers `⊑`, and the
  [select documentation](https://mlochbaum.github.io/BQN/doc/select.html) covers `⊏`.
- The [indices documentation](https://mlochbaum.github.io/BQN/doc/indices.html) explains counting from `0`.

## 1. Look up a product

- You want one element, not a list holding it.

## 2. Pack an order

- One function takes a whole list of indices.

## 3. Find the newest product

- Negative indices count from the end.

## 4. Read a slot code

- Turn the letter and the digit into numbers by subtracting the first letter and the first digit.
- Remember that `"A1"` is slot `0`, not slot `1`.

## 5. Scroll the display

- `↕ 8` gives eight indices in a row; add the start to all of them.
- Modulus by the message's length brings indices past the end back to the start.
