# Instructions

The swimming pool's locker room is going digital.
Each locker is a record in memory of three cells:

| Cell | Holds                                         |
| ---- | --------------------------------------------- |
| 0    | the owner's membership number                 |
| 1    | the combination that opens it                 |
| 2    | a flag: true when the locker is open          |

A locker is handed around by the address of its first cell.

## 1. Install a locker

Define `new-locker ( owner combination -- locker )`, which lays down a new, closed locker for that owner and combination in the dictionary and leaves its address.

```forth
1042 7319 new-locker   \ leaves the address of a new locker
```

## 2. Read a locker

Define `owner ( locker -- owner )` and `combination ( locker -- combination )`.

```forth
1042 7319 new-locker dup owner .   \ prints 1042
combination .                      \ prints 7319
```

## 3. Open a locker

Define `open? ( locker -- flag )`, true when the locker is open, and `try-open ( combination locker -- flag )`.
`try-open` opens the locker and leaves true when the combination is right; with a wrong combination it leaves false and does not change the locker.

```forth
1042 7319 new-locker  7319 over try-open .   \ prints -1
open? .                                      \ prints -1
```

## 4. Lock up

Define `lock-up ( locker -- )`, which closes a locker.

```forth
1042 7319 new-locker  7319 over try-open drop  dup lock-up  open? .   \ prints 0
```

## 5. Hand a locker over

Define `reassign ( owner combination locker -- )`, which gives the locker a new owner and combination and closes it.

```forth
1042 7319 new-locker  2001 1111 2 pick reassign  owner .   \ prints 2001
```
