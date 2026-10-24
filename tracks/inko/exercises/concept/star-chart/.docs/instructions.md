# Instructions

Every clear night, Noor climbs to her roof with a telescope and a hand-drawn star chart. The chart is a grid: a
star's position is its column and its row, both whole numbers. She records each star she sees as its name, its
_magnitude_ (how bright it looks; smaller numbers are brighter, and the brightest stars have negative magnitudes)
and its position. Help her put her chart into code.

## 1. Mark a position

Define the `position` method, which takes a column and a row and returns them as a pair:

```inko
position(column: 18, row: 36)
# => (18, 36)
```

## 2. Shift a position

The sky turns during the night, so Noor shifts her marks. Define the `shift` method, which takes a position and an
offset (a pair of columns and rows to move by) and returns the new position:

```inko
shift((18, 36), by: (2, -1))
# => (20, 35)
```

## 3. Count the steps between two stars

Noor sweeps her telescope one grid square at a time, across or up and down, never diagonally. Define the `steps`
method, which returns how many squares the telescope moves to get from one position to another:

```inko
steps(from: (1, 1), to: (4, -3))
# => 7
```

## 4. Find the brighter star

Define the `brighter` method, which takes two stars, each a name and a magnitude, and returns the name of the
brighter one (the one with the smaller magnitude). When both are equally bright, return the first:

```inko
brighter(('Vega', 0.03), ('Sirius', -1.46))
# => 'Sirius'
```

## 5. Write a catalogue entry

Define the `catalogue_entry` method, which takes a star as its name, magnitude and position, and returns a line for
Noor's catalogue:

```inko
catalogue_entry(('Vega', 0.03, (18, 36)))
# => 'Vega (0.03) at 18,36'
```
