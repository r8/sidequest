# Introduction

`[` switches to interpreting in the middle of a definition and `]` switches back, so code between them runs while the definition is compiled.
`literal ( x -- )` then compiles the number it computed:

```forth
: minutes-per-week ( -- n )
  [ 7 24 * 60 * ] literal ;   \ the product is worked out once
```

gforth's `]L` is short for `] literal`.
Computing at compile time saves work at run time, and it captures a value as it was then: `[ rate @ ] literal` keeps the rate the definition was compiled with, while `rate @` fetches the current one each time.
