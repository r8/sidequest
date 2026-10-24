# Instructions

You're moving house, and you've decided to be organised about it. Every item has a numbered sticker, and every
box is written down as the list of what is in it, which may include smaller boxes: the box of kitchen things
holds a box of cutlery. Now you need a few tools to keep track of it all.

An item is a number and a box is a list of items and boxes.

## 1. Count the layers

Write the function `Layers`. It takes an item or a box and returns how many layers of boxes its most deeply
packed item is inside: 0 for an item on its own, 1 for a box of items, and so on.

```bqn
Layers ⟨1, ⟨2, 3⟩, 4⟩
# ⇒ 2
```

## 2. Empty boxes into one

Write the function `Unpack`. It takes a list of boxes and returns a single box holding their contents, box after
box, in order. Boxes inside the boxes stay closed.

```bqn
Unpack ⟨1‿2, ⟨3⟩, ⟨⟩, ⟨4, 5‿6⟩⟩
# ⇒ ⟨ 1 2 3 4 ⟨ 5 6 ⟩ ⟩
```

## 3. Put something in a box

Write the function `AddItem`. Its left argument is a box and its right argument an item or a box; it returns the
box with that one thing added at the end, as a single element.

```bqn
1‿2 AddItem 3‿4
# ⇒ ⟨ 1 2 ⟨ 3 4 ⟩ ⟩
```

## 4. Label a box

Write the function `Label`. Its left argument is a label (a string) and its right argument a box; it returns a
two-element list of the label and the box.

```bqn
"kitchen" Label 1‿2‿3
# ⇒ ⟨ "kitchen" ⟨ 1 2 3 ⟩ ⟩
```

## 5. Stack the boxes on a shelf

Boxes of the same size go on the shelf in rows. Write the function `Shelve`. It takes a list of boxes that all
hold the same number of items and returns a table with one row per box.

```bqn
Shelve ⟨1‿2‿3, 4‿5‿6⟩
# ⇒ a 2×3 table: 1 2 3 / 4 5 6
```

## 6. Find the identical boxes

Write the function `Matches`. Its left argument is a list of boxes and its right argument one box; it returns 1
for each box of the list with exactly the same contents, in the same order, and 0 for the others.

```bqn
⟨1‿2, 2‿1, 1‿2‿3, 1‿2⟩ Matches 1‿2
# ⇒ ⟨ 1 0 0 1 ⟩
```
