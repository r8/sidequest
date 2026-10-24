# Instructions

Commander Okoro keeps the crew roster of the research station _Halcyon_ on a tired old terminal.
Each crew member is a record: an id number, a rank, the number of shifts worked, and the letter of the deck they live on.
Help her replace the hand-counted offsets with a structure, and write the roster words on top of it.

## 1. Describe a crew member

Replace the stub's placeholder words with a structure `crew-member`, whose fields are:

- `member-id`, a cell;
- `member-rank`, a cell;
- `member-shifts`, a cell;
- `member-deck`, a character.

`crew-member ( -- u )` is the size of one record, and each field word is `( addr -- addr' )`.

```forth
create cook  crew-member allot
7 cook member-id !
cook member-id @   \ leaves 7
```

## 2. Enlist a crew member

Define `enlist ( id rank deck addr -- )`, which fills in the record at `addr`: the given id, rank and deck, and no shifts worked yet.

```forth
create cook  crew-member allot
17 2 [char] C cook enlist
cook member-deck c@   \ leaves the character C
```

## 3. Promote a crew member

Define `promote ( addr -- )`, which raises the rank of the crew member at `addr` by one.

```forth
cook promote
cook member-rank @   \ leaves 3
```

## 4. Find a crew member in the roster

The roster is an array of records, one after another.
Define `crew-at ( roster i -- addr )`, the address of the `i`-th record (counting from 0).

```forth
create roster  4 crew-member * allot
roster 2 crew-at   \ leaves the address of the third record
```

## 5. Find the most senior crew member

Define `most-senior ( roster n -- id )`, the id of the crew member with the highest rank among the first `n` records of the roster (`n` is at least 1).
When several share the highest rank, it is the one who comes first.

```forth
roster 4 most-senior   \ leaves an id
```
