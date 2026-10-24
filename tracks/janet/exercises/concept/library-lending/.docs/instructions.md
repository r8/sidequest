# Instructions

The village of Little Hollow has a lending library of one room and a few hundred books, run by Agathe.
Its rules are strict: a book taken from the shelf comes back to the shelf, no matter what happens while someone is reading it.
Agathe keeps the shelf as a table from each title to where the book is — `:in`, `:out`, or `:reading` — and she wants the rules enforced by code.

## 1. Read in the library

A visitor may read a book in the library: the book is `:reading` while they do, and back `:in` afterwards — even if the visitor drops it, which is to say even if reading raises an error.
Define the function `read-here` that takes the shelf, a title and a function of one argument (the title), marks the book `:reading`, calls the function with the title, puts the book back `:in`, and returns what the function returned.

```janet
(def shelf @{"Emma" :in})
(read-here shelf "Emma" (fn [title] (string "enjoyed " title)))
# => "enjoyed Emma"
shelf
# => @{"Emma" :in}
```

## 2. Lend a book

To take a book home, the visitor fills in a card.
Define the function `lend` that takes the shelf, a title and a function (which fills in the card, given the title), marks the book `:out`, calls the function, and returns what it returned.
If filling in the card fails with an error, the book must be back `:in` and the error passed on; if it succeeds, the book stays `:out`.

```janet
(def shelf @{"Emma" :in})
(lend shelf "Emma" (fn [title] {:title title :due "May 3"}))
# => {:title "Emma" :due "May 3"}
shelf
# => @{"Emma" :out}
```

## 3. Open the reading room

The reading room is a table that records what happens in it.
Define the function `reading-room` that takes a log (an array) and returns a reading room: a table with the log under `:log` and a `:close` method that pushes `"room closed"` onto the log.

```janet
(def log @[])
(def room (reading-room log))
(:close room)
log
# => @["room closed"]
```

## 4. Study in the reading room

Define the function `study` that takes a log and a function of one argument, opens a reading room on that log, calls the function with the room, and returns what the function returned.
The room must be closed afterwards, error or not.

```janet
(def log @[])
(study log (fn [room] (array/push (room :log) "studied maps") :done))
# => :done
log
# => @["studied maps" "room closed"]
```

## 5. Borrow the archive key

The archive is locked, and its keys hang on a ring (an array).
Define the function `with-archive-key` that takes the key ring and a function of one argument, takes the last key off the ring, calls the function with it, and returns what it returned.
The key must be back on the ring afterwards, error or not.

```janet
(def ring @["brass key" "iron key"])
(with-archive-key ring (fn [key] (string "opened with the " key)))
# => "opened with the iron key"
ring
# => @["brass key" "iron key"]
```
