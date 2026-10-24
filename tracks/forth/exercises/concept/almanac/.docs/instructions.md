# Instructions

The _Harbourmaster's Almanac_ has been printed every year for two centuries, and this year its tables are being typeset by a Forth program.
The editor, Mr Lindqvist, cares about two things: that the numbers are worked out once, when the almanac is put together, and that every footnote is accounted for.

The stub defines the edition number, and the count of footnotes:

```forth
variable edition  3 edition !
variable footnotes
```

## 1. Work out the seconds in a day

Define `seconds-per-day ( -- n )`, the number of seconds in a day, worked out from 24 hours of 60 minutes of 60 seconds when the word is compiled, so that running it only pushes the result.

```forth
seconds-per-day   \ leaves 86400
```

## 2. Print the edition

The front page shows the edition the almanac was put together for, even if `edition` changes later; the back page shows the current one.
Define `printed-edition ( -- n )`, the value `edition` had when `printed-edition` was compiled, and `current-edition ( -- n )`, the value it has now.

```forth
9 edition !
printed-edition   \ leaves 3
current-edition   \ leaves 9
```

## 3. Count the footnotes

Define `footnote ( -- )`, an immediate word that adds one to the variable `footnotes` each time it is compiled into a definition, and compiles nothing: the definition behaves as if it were not there.

```forth
: tide-table ( -- n ) footnote 12 footnote ;
footnotes @   \ leaves 2
tide-table    \ leaves 12
```

## 4. Refuse footnotes outside a definition

A footnote has to belong to an entry.
Make `footnote` throw -14 (interpreting a compile-only word) when it is used while interpreting.

```forth
footnote   \ throws -14
```
