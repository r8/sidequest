# Instructions

The night shift at Gravel Lane shunting yard rearranges goods trains before they leave at dawn. The yard has
little room: there is no spare track to build a second train on, so every move must reuse the wagons already
there. Trains are lists of wagon numbers (or of cargo names), front of the train first.

Write each function as described, and mark it with the keyword given in its doc comment in the stub (`fip`,
`fbip` or `fip(1)`), so that the compiler checks it works in place. The tests check the results; the compiler's
warnings tell you whether the annotation holds.

## 1. Turn a train around

Define `reverse-train`: it takes a train and returns it with its wagons in the opposite order, as a `fip`
function.

```koka
reverse-train([1, 2, 3])
// => [3, 2, 1]
```

## 2. Renumber the wagons

A train has been sold to another railway, which numbers its wagons from a different starting point. Define
`renumber`: it takes a train and an offset and returns the train with the offset added to every wagon number, as
a `fip` function.

```koka
renumber([1, 2, 7], 100)
// => [101, 102, 107]
```

## 3. Swap neighbours

Define `swap-pairs`: it takes a train and swaps its first and second wagon, its third and fourth, and so on; the
last wagon of a train with an odd number of wagons stays where it is. Make it `fip`.

```koka
swap-pairs([1, 2, 3, 4, 5])
// => [2, 1, 4, 3, 5]
```

## 4. Uncouple wagons

Define `uncouple`: it takes a train and a wagon number and returns the train without any of the wagons that have
that number. Uncoupled wagons are gone, so their memory is freed: make it `fbip`.

```koka
uncouple([9, 4, 9, 5], 9)
// => [4, 5]
```

## 5. Park in the sidings

The yard's sorting sidings are a tree, given in the stub as the type `yard`: each `Siding` holds one wagon, with
the sidings for smaller numbers on its left and those for larger numbers on its right, and `Buffer` ends a line.
Define `park`: it takes a yard and a wagon number and returns the yard with the wagon on a siding of its own in
the right place, or the yard unchanged if that wagon is already parked. A new siding has to be built for the new
wagon, so make it `fip(1)`.

```koka
Buffer.park(5).park(1).park(8).tracks
// => [1, 5, 8]
```
