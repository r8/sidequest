# Introduction

The comparison words take two numbers and leave a well-formed flag, reading in written order: `a b <` asks whether `a` is less than `b`.

| Word | True when |
| --- | --- |
| `=` `<>` | equal, not equal |
| `<` `>` | less, greater |
| `<=` `>=` | at most, at least |
| `0=` `0<>` `0<` `0>` | compared with zero (one number) |

`within ( n lo hi -- flag )` is true when `lo <= n < hi`; the upper bound is excluded, so a range from 1 through 10 is `1 11 within`.

```forth
3 5 < .           \ -1
7 7 >= .          \ -1
10 1 10 within .  \ 0
```
