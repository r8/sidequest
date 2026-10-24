# Introduction

`n constant name` names a number that never changes; `name` then pushes the number itself:

```forth
60 constant minutes-per-hour
```

`n value name` is the same, except that `m to name` changes it later, at the top level or inside a definition:

```forth
100 value speed-limit
: slow-zone ( -- ) 30 to speed-limit ;
```

Constants and values push their number, so they are never used with `@` or `!`; that is what variables are for.
