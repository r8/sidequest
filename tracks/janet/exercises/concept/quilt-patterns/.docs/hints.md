# Hints

## General

- The [loop page](https://janet-lang.org/docs/loop.html) of the Janet documentation lists every verb and modifier.
- [`seq`](https://janet-lang.org/api/index.html#seq), [`tabseq`](https://janet-lang.org/api/index.html#tabseq) and [`catseq`](https://janet-lang.org/api/index.html#catseq) take the same head as [`loop`](https://janet-lang.org/api/index.html#loop).

## 1. Lay out a checkerboard

- One `seq` inside another gives an array of rows.
- A patch is light when the sum of its row and column is even.

## 2. Find the border patches

- Two bindings in one head visit every position in reading order.
- A modifier can skip the positions that are not on an edge: the first or last row, or the first or last column.

## 3. Count the fabric

- Nothing needs collecting here: create a table, then use `loop` to update it for every patch.
- `(get t k 0)` gives a default for a colour not seen yet.

## 4. Number the palette

- Iterating over `:pairs` of a tuple gives each index together with its value.
- `tabseq` takes the key and then the value after the head.

## 5. Repeat a strip

- One verb repeats a body a number of times by counting; you do not need the counter itself, so name it `_`.
- `catseq` joins the collections the body produces.
