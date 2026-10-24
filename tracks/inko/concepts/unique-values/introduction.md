# Introduction

A unique value, `uni T`, is a value that nothing outside it refers to and that refers to nothing outside itself.
`recover expression` turns a `T` built inside the expression into a `uni T`, and a `uni T` back into a `T`:

```inko
let numbers = recover [10, 20] # uni Array[Int]
let owned = recover numbers    # Array[Int]
```

Inside `recover`, captured variables are restricted so no borrow can escape; build the value from fresh data, value
types and other `uni` values (`recover list.clone`). Methods may be called on a `uni T` when their arguments and
results are sendable. Unique values and value types are what can be sent between processes.
