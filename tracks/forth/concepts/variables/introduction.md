# Introduction

`variable name` creates a named cell of memory; `name` pushes its _address_.
`!` `( x addr -- )` stores into it, `@` `( addr -- x )` fetches from it, and `+!` `( n addr -- )` adds to it in place:

```forth
variable visits
0 visits !
: visit ( -- ) 1 visits +! ;
: visits? ( -- n ) visits @ ;
```

Declare variables at the top level, before the words that use them, and store a starting value before relying on one.
Forgetting `@` (`visits 1+`) does arithmetic on the address instead of the number.
