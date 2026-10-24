# Introduction

Forth has no boolean type: a _flag_ is a cell, `0` for false and anything else for true.
Words that produce flags leave _well-formed_ ones, `0` (`false`) or `-1` (`true`, every bit set).

`and`, `or`, `xor` and `invert` work bit by bit, so on well-formed flags they are the logical operators:

```forth
: teenager? ( age -- flag )
  dup 13 >= swap 20 < and ;
```

`0=` negates any flag, whatever its true value; `invert` only negates well-formed ones.
Because true is `-1`, `negate` turns a flag into `1` or `0`, and flags can be added to count.
