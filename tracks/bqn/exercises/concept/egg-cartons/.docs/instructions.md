# Instructions

Hilltop Farm sells its eggs in cartons of two rows of six. The packing machine weighs every egg as it rolls
off the belt, in grams, and the farm wants the cartons and crates described in the same terms the machine uses:
arrays of weights.

## 1. Pack a carton

Write the function `Carton`. It takes the weights of twelve eggs, in the order they came off the belt, and
returns the carton: a table of two rows of six, filling the first row before the second.

```bqn
Carton 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
# ⇒ a 2×6 table: 61 58 63 60 59 62 / 64 57 60 61 58 63
```

## 2. Measure a tray

Write the function `Dimensions`. It takes a carton, a crate (see task 6), or any other tray of eggs and returns
its shape.

```bqn
Dimensions Carton 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
# ⇒ ⟨ 2 6 ⟩
```

## 3. Count the eggs

Write the function `EggCount`. It takes a tray of any shape and returns how many eggs it holds.

```bqn
EggCount Carton 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
# ⇒ 12
```

## 4. Unpack a tray

Write the function `Unpack`. It takes a tray of any shape and returns the weights as a single list, in the
order they were packed.

```bqn
Unpack Carton 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
# ⇒ ⟨ 61 58 63 60 59 62 64 57 60 61 58 63 ⟩
```

## 5. Turn a carton

The shop displays cartons on their side. Write the function `Turn`. It takes a carton and returns it turned so
that its columns become rows: six rows of two, the first row holding the first egg of each original row.

```bqn
Turn Carton 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
# ⇒ a 6×2 table: 61 64 / 58 57 / 63 60 / 60 61 / 59 58 / 62 63
```

## 6. Fill a crate

Cartons are shipped stacked in crates. Write the function `Crate`. Its left argument is the number of cartons
in the crate and its right argument the weights of the eggs, twelve per carton, in order; it returns the crate
as an array of that many cartons, each two rows of six.

```bqn
2 Crate 1+↕24
# ⇒ an array of shape 2‿2‿6: two cartons, the first holding 1 to 12
```
