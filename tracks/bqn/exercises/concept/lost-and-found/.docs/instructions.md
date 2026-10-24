# Instructions

You have taken a summer job at the lost-and-found office of the central station. Every item handed in gets a tag,
and the office keeps lists side by side: the items' descriptions, how many days each has been held, and whether
its owner has come for it. Your manager wants the paperwork done by computer this year.

## 1. List the unclaimed items

Write the function `Unclaimed`. Its left argument is a list of claimed flags (`1` if the owner collected the item,
`0` if not) and its right argument the items; it returns the items still waiting for their owners.

```bqn
1‿0‿0‿1 Unclaimed "umbrella"‿"glove"‿"phone"‿"scarf"
# ⇒ ⟨"glove", "phone"⟩
```

## 2. Find the items held too long

Items held longer than a limit go to charity. Write the function `Overdue`. Its left argument is the limit in days
and its right argument the days each item has been held; it returns the positions (counting from `0`) of the items
held longer than the limit.

```bqn
30 Overdue 3‿45‿31‿30
# ⇒ ⟨1, 2⟩
```

## 3. Expand the delivery note

Cleaners hand in a note listing each kind of item with how many they found. Write the function `Expand`. Its left
argument is the counts and its right argument the kinds; it returns one entry per item.

```bqn
2‿1 Expand "glove"‿"hat"
# ⇒ ⟨"glove", "glove", "hat"⟩
```

## 4. Read the claim ticket

Owners bring a ticket whose number is printed between letters, dashes and spaces. Write the function
`TicketDigits`. It takes the ticket text and returns only its digits, in order.

```bqn
TicketDigits "A-12 / 7"
# ⇒ "127"
```

## 5. Number the shelves

Items are stored shelf by shelf. Write the function `ShelfNumbers`. It takes the number of items on each shelf
(shelf `0` first) and returns the shelf number of every item, in storage order.

```bqn
ShelfNumbers 2‿0‿3
# ⇒ ⟨0, 0, 2, 2, 2⟩
```
