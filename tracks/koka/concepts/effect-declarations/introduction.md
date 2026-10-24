# Introduction

An effect declaration introduces a new effect type and its operations:

```koka
pub effect lamp
  fun brightness() : int
  fun dim(by : int) : ()

effect fun log(message : string) : ()   // one operation, named like the effect
effect val room : string                // an operation that provides a value
```

Operations are called like functions (`brightness()`, `room`), and a function that calls one gets the effect in
its type: `fun label() : room string`. The declaration says what can be asked, not how it is answered — a
handler decides that, and until one is installed the effect stays in the type.
