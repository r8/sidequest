# Instructions

Tomás is building a universal remote control for the hotel where he works.
For now it controls only the volume of the television in each room, from 0 (silent) to 10 (loudest), and it has four buttons.
The stub defines what each button does:

| Button | Word | Effect |
| --- | --- | --- |
| 0 | `louder` | one step louder, but not above 10 |
| 1 | `quieter` | one step quieter, but not below 0 |
| 2 | `mute` | volume 0 |
| 3 | `loudest` | volume 10 |

Each of them has the stack effect `( volume -- volume' )`.

## 1. Press a button twice

Define `twice ( x xt -- x' )`, which runs the word `xt` stands for on `x`, and then again on the result.

```forth
3 ' louder twice   \ leaves 5
```

## 2. Find a button's action

Define `button ( n -- xt )`, the execution token of button `n`'s word, from the table above.

```forth
2 button   \ leaves the xt of mute
```

## 3. Press a button

Define `press ( volume n -- volume' )`, the volume after pressing button `n`.

```forth
4 0 press   \ leaves 5
```

## 4. Replay a sequence

The remote can record a sequence of button presses, as an array of `n` button numbers at `addr`.
Define `press-all ( volume addr n -- volume' )`, the volume after pressing each button of the sequence in order.

```forth
create bedtime  2 , 0 , 0 ,
8 bedtime 3 press-all   \ leaves 2
```

## 5. Adjust every room

The front desk keeps the volume of every room in an array of `n` cells at `addr`.
Define `apply-to-all ( addr n xt -- )`, which replaces each volume in the array with the result of running `xt` on it.

```forth
create rooms  3 , 7 , 10 ,
rooms 3 ' louder apply-to-all   \ rooms now holds 4 8 10
```
