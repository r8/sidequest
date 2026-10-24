// A bank account, as a value: every operation returns the updated account.
abstract type account
  Closed
  Opened(funds : int)

// new-account() -> an account that has not been opened yet
pub fun new-account() : account
  Closed

// open(a) -> `a` opened with a balance of 0; throws "account already open" if it is open
pub fun open(a : account) : exn account
  match a
    Closed -> Opened(0)
    Opened -> throw("account already open")

// close(a) -> `a` closed; throws "account not open" if it is not open
pub fun close(a : account) : exn account
  match a
    Opened -> Closed
    Closed -> throw("account not open")

// balance(a) -> the balance of `a`; throws "account not open" if it is not open
pub fun balance(a : account) : exn int
  match a
    Opened(funds) -> funds
    Closed -> throw("account not open")

fun check-positive(amount : int) : exn ()
  if amount <= 0 then throw("amount must be greater than 0")

// deposit(a, amount) -> `a` with `amount` added to its balance; throws "account not open" if it is not
// open, and "amount must be greater than 0" unless `amount` is positive
pub fun deposit(a : account, amount : int) : exn account
  val funds = a.balance
  check-positive(amount)
  Opened(funds + amount)

// withdraw(a, amount) -> `a` with `amount` taken from its balance; throws "account not open" if it is not
// open, "amount must be greater than 0" unless `amount` is positive, and "amount must be less than balance"
// if `amount` is more than the balance
pub fun withdraw(a : account, amount : int) : exn account
  val funds = a.balance
  check-positive(amount)
  if amount > funds then throw("amount must be less than balance")
  Opened(funds - amount)
