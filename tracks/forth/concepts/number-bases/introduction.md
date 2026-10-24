# Introduction

`base` is a variable holding the radix Forth reads and prints numbers in, normally 10.
`hex` and `decimal` set it to 16 and 10; any base from 2 to 36 can be stored with `base !`.
Pictured output follows `base` too, with upper-case letters for digits above 9.

```forth
255 hex . decimal          \ FF
: .binary ( n -- )  base @ >r  2 base !  .  r> base ! ;
```

A word that changes `base` should restore it, keeping the old value on the return stack meanwhile.
Prefixed literals ignore `base`: `$ff` (hex), `%101` (binary), `#10` (decimal).
