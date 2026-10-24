# Introduction

`if` runs a block when its condition is `true`; `else if` and `else` handle the other cases. Braces are required:

```inko
if temperature < 0 {
  'freezing'
} else if temperature < 20 {
  'mild'
} else {
  'warm'
}
```

`if` with `else` is an expression, so its value can be returned or assigned:

```inko
let label = if score >= 50 { 'pass' } else { 'fail' }
```

Every branch must produce the same type. An `if` without `else` produces `Nil`.
