# Introduction

`evaluate ( i*x c-addr u -- j*x )` interprets a string as Forth source, exactly as if it were a line of the program, then returns to the input it came from.

```forth
s" 2 3 +" evaluate .   \ prints 5
```

The string can do anything a line can: compute, define words, use parsing words (which read from the string).
Its stack effect is whatever the text does, applied to the stack below the string, which is consumed first.
`evaluate` lets a program run code it built or stored at run time, with the full text interpreter.
