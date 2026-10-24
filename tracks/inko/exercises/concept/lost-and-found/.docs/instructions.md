# Instructions

Frieda runs the lost-and-found office at Central Station. Whoever finds something hands it in and gets a numbered
claim ticket; the owner brings the ticket back to collect it. Not every visitor has a ticket, not every ticket is
valid, and not every description matches an item, so nearly every question in Frieda's office has the answer
"maybe".

## 1. Check a ticket number

Valid tickets are numbered from 1 to 999. Define the `ticket` method, which returns the number wrapped in a `Some`
when it is valid, and `None` otherwise:

```inko
ticket(42)
# => Option.Some(42)
ticket(1200)
# => Option.None
```

## 2. Read a handwritten ticket

People often just tell Frieda their number. Define the `read_ticket` method, which takes the text and returns the
ticket it names, or `None` when the text isn't a number or the number isn't a valid ticket:

```inko
read_ticket('42')
# => Option.Some(42)
read_ticket('forty-two')
# => Option.None
```

## 3. Find an item

Define the `find_item` method, which takes the list of item descriptions and a word, and returns the first
description that contains the word, or `None` when none does:

```inko
find_item(['red umbrella', 'blue scarf', 'green umbrella'], 'umbrella')
# => Option.Some('red umbrella')
```

## 4. Find the shelf

Items are stored on 20 shelves: the item with ticket `n` is on shelf `(n % 20) + 1`. Define the `shelf` method, which
takes a ticket that may be missing and returns the shelf number, or `None` without a ticket:

```inko
shelf(Option.Some(42))
# => Option.Some(3)
```

## 5. Print the ticket label

Define the `label` method, which takes a ticket that may be missing and returns `'Ticket 42'`, or `'No ticket'`:

```inko
label(Option.Some(42))
# => 'Ticket 42'
label(Option.None)
# => 'No ticket'
```
