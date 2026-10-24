# Hints

## General

- [Deferred words](https://gforth.org/manual/Deferred-Words.html) in the Gforth manual covers `defer`, `is`, `action-of`, `defer!` and `defer@`.

## 1. Create the role

- A deferred word needs something put into it before it is first used: do that right after defining it.

## 2. Cast an actor

- `is` works inside a definition, taking the xt from the stack when the definition runs.

## 3. Ask who is playing

- There is a word that gives back what a deferred word holds.

## 4. Send on an understudy for one scene

- Save the current actor before casting the new one, and keep it out of the way while `hamlet` runs.
- `hamlet` leaves its number on top of the saved xt; a shuffle brings the xt back up.

## 5. Rehearse the alternating lines

- With one line left, the reader of the next line reads the last one.
- With more lines, one is read and the other actor reads next.
- A word can only call words defined before it, so one of the two has to be a deferred word, filled in once the other exists.
