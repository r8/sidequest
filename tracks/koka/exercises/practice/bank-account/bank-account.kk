// A bank account, as a value: every operation returns the updated account. Its representation is up to
// you: give this type its constructor(s).
pub type account

// new-account() -> an account that has not been opened yet
pub fun new-account() : exn account
  throw("implement me", ExnTodo)

// open(a) -> `a` opened with a balance of 0; throws "account already open" if it is open
pub fun open(a : account) : exn account
  throw("implement me", ExnTodo)

// close(a) -> `a` closed; throws "account not open" if it is not open
pub fun close(a : account) : exn account
  throw("implement me", ExnTodo)

// balance(a) -> the balance of `a`; throws "account not open" if it is not open
pub fun balance(a : account) : exn int
  throw("implement me", ExnTodo)

// deposit(a, amount) -> `a` with `amount` added to its balance; throws "account not open" if it is not
// open, and "amount must be greater than 0" unless `amount` is positive
pub fun deposit(a : account, amount : int) : exn account
  throw("implement me", ExnTodo)

// withdraw(a, amount) -> `a` with `amount` taken from its balance; throws "account not open" if it is not
// open, "amount must be greater than 0" unless `amount` is positive, and "amount must be less than balance"
// if `amount` is more than the balance
pub fun withdraw(a : account, amount : int) : exn account
  throw("implement me", ExnTodo)
