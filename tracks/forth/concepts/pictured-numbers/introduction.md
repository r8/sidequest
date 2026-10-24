# Introduction

Pictured numeric output turns a number into a string, built from the rightmost character to the leftmost:

```forth
: percent ( n -- c-addr u )   0 <# [char] % hold #s #> ;
: celsius ( n -- c-addr u )   dup abs 0 <# [char] C hold #s rot sign #> ;
```

`<#` starts, `#` adds one digit (zeros included), `#s` adds the rest, `hold` adds a character and `sign` a `-` for a negative number; `#>` leaves `( c-addr u )`.
The number is a double cell, so a non-negative single needs a 0 above it.
The result lives in a system buffer, valid until the next picture.
