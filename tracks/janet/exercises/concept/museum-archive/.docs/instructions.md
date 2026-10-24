# Instructions

The Riverside Museum is moving its catalogue from a card index to a computer.
Each object is a _record_: its accession number, its name, and a few notes the curators have written about it.
While a record is being edited it is a table; once it has been checked, the museum wants it sealed so that nothing can change it by accident.
Help the archivist, Ruth, with the tools for handling records.

## 1. Compare two records

Two curators sometimes enter the same object twice.
Define the function `same-record?` that takes two records of the same kind — both tables or both structs, possibly with arrays or tuples inside — and returns `true` when they hold the same contents, and `false` otherwise.

```janet
(same-record? @{:id 17 :notes @["bronze"]} @{:id 17 :notes @["bronze"]})
# => true
```

## 2. Seal a record

Define the function `seal` that takes a record and returns a copy of it in which nothing can change: no tables, arrays or buffers at any level.
The original record must stay as it was.

```janet
(seal @{:id 17 :name @"Helmet" :notes @["bronze"]})
# => {:id 17 :name "Helmet" :notes ("bronze")}
```

## 3. Reopen a record

When a sealed record needs correcting, Ruth reopens it.
Define the function `reopen` that takes a sealed record and returns a copy in which everything can be changed again: tables, arrays and buffers at every level.

```janet
(reopen {:id 17 :name "Helmet" :notes ["bronze"]})
# => @{:id 17 :name @"Helmet" :notes @[@"bronze"]}
```

## 4. Copy the visitor log

The visitor log is an array of names.
Ruth wants to hand a copy to the café downstairs without the café's additions turning up in the museum's log.
Define the function `copy-log` that takes the log and returns a new array with the same names, which can be changed without changing the log.

```janet
(copy-log @["Ada" "Bo"])
# => @["Ada" "Bo"]
```

## 5. Add a note to a sealed record

Some notes are added without reopening the whole record.
Define the function `add-note` that takes a sealed record (a struct) and a note and returns a new sealed record whose `:notes` tuple has the note added at the end.
A record without notes gets a `:notes` tuple with just the new note.
The original record must stay as it was.

```janet
(add-note {:id 17 :notes ["bronze"]} "dented")
# => {:id 17 :notes ("bronze" "dented")}
```
