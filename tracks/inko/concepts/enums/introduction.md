# Introduction

`type enum` defines a type whose values are one of a fixed set of cases, each optionally carrying data:

```inko
type pub enum Payment {
  case Cash(Int)
  case Card(String, Int)
  case Voucher
}

let payment = Payment.Card('4111-1111', 1250)
```

`match` tells the cases apart and binds their data; listing every case makes it exhaustive without a wildcard:

```inko
match payment {
  case Cash(cents) -> cents
  case Card(_, cents) -> cents
  case Voucher -> 0
}
```

Enums can define methods after their cases. `Option` and `Result` are enums.
