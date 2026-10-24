# Introduction

A handler is installed by an ordinary function, so its clauses can use that function's local `var`s. A variable
declared before `with handler` lives as long as the handled computation and remembers what earlier operations
did:

```koka
fun with-budget(money : int, action : () -> <spend|e> a) : e a
  var left := money
  with fun spend(amount)
    if amount <= left then
      left := left - amount
      True
    else False
  action()
```

Every call of the handler function makes a fresh variable, the action sees only the operations, and because the
variable is local the handler's type shows no state effect: just `e a`.
