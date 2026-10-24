// vend(price, paid) -> the change from `paid` coins; throws "not enough money" if `paid` is less than `price`
pub fun vend(price : int, paid : int) : exn int
  throw("implement me", ExnTodo)

// try-vend(price, paid) -> the change from `paid` coins, or `Nothing` if the sale fails
pub fun try-vend(price : int, paid : int) : exn maybe<int>
  throw("implement me", ExnTodo)

// vend-or-refund(price, paid) -> the change from `paid` coins, or `paid` if the sale fails
pub fun vend-or-refund(price : int, paid : int) : exn int
  throw("implement me", ExnTodo)

// panel-text(price, paid) -> "change: <change>", or "error: <message>" if the sale fails
pub fun panel-text(price : int, paid : int) : exn string
  throw("implement me", ExnTodo)

// vend-all(prices, paid) -> the change after buying every item of `prices` in order; throws "not enough money"
// if the coins run out
pub fun vend-all(prices : list<int>, paid : int) : exn int
  throw("implement me", ExnTodo)
