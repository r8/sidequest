# Instructions

Ferris is a warehouse robot programmed in Forth.
Its engineers want its control programs to read like a little language of their own, and its controller is slow, so they want new syntax that costs nothing when the robot runs: words that do their work while a program is compiled.

Every word in this exercise is immediate and is used inside definitions.

## 1. Square without a call

Define `squared`, a macro that compiles code to square the number on top of the stack, so that a definition using it behaves as `( n -- n*n )` without calling any word named `squared`.

```forth
: reach ( n -- n*n ) squared ;
7 reach   \ leaves 49
```

## 2. Act unless

Define `unless`, which works like `if` but runs the code that follows it when the flag is false.
It is ended by `then`, and it can have an `else`.

```forth
: move-or-wait ( blocked? -- n ) unless 1 else 0 then ;
false move-or-wait   \ leaves 1
true move-or-wait    \ leaves 0
```

## 3. Do it twice

Define `twice`, which reads the next word of the definition and compiles it twice.

```forth
: two-forward ( n -- n+2 ) twice 1+ ;
5 two-forward   \ leaves 7
```

## 4. Number the steps

The engineers number each step of a program as it is written.
Define `step`: each use of it in a definition adds one to the variable `steps` at compile time, and compiles the new value as a literal, so the definition pushes that step's number every time it runs.
The stub defines `steps`.

```forth
0 steps !
: route ( -- n1 n2 n3 ) step step step ;
route   \ leaves 1 2 3
route   \ leaves 1 2 3 again
```

## 5. Repeat a move

Define `times ( n -- )` and `end-times`, a loop that runs the code between them `n` times, with `i` counting from 0, and not at all when `n` is 0.

```forth
: sweep ( n -- total ) 0 swap times i + end-times ;
5 sweep   \ leaves 10
0 sweep   \ leaves 0
```
