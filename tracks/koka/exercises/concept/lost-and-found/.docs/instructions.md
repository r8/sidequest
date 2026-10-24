# Instructions

The lost property office at Riverside station keeps every forgotten item on a numbered shelf. The first slot
on a shelf is slot `0`. Travellers who reclaim something hand over the ticket they were given, with the slot
number written on it — when it is legible. You are replacing the office's card index with a small program.

## 1. Read a ticket

Define the `ticket-number` function: it takes the text written on a ticket and returns the slot number it
names, or `Nothing` when the text is not a whole number or the number is negative.

```koka
ticket-number("12")
// => Just(12)
ticket-number("twelve")
// => Nothing
```

## 2. Show the first item

Define the `first-item` function: it takes a shelf (a list of item names) and returns the name of its first
item, or `"empty shelf"` when there is none.

```koka
first-item(["umbrella", "scarf"])
// => "umbrella"
```

## 3. Label the owner

Define the `owner-label` function: it takes the owner of an item, if known, and returns the label for the
item's tag: `"Owner: <name>"`, or `"Owner unknown"`.

```koka
owner-label(Just("Ada"))
// => "Owner: Ada"
```

## 4. Hand an item back

Define the `claim` function: it takes a shelf and the text on a ticket and returns the item in the slot the
ticket names, or `Nothing` when the ticket cannot be read or that slot is past the end of the shelf.

```koka
claim(["umbrella", "scarf", "violin"], "2")
// => Just("violin")
```
