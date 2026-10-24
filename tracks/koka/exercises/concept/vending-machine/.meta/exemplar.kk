// vend(price, paid) -> the change from `paid` coins; throws "not enough money" if `paid` is less than `price`
pub fun vend(price : int, paid : int) : exn int
  if paid < price then throw("not enough money") else paid - price

// try-vend(price, paid) -> the change from `paid` coins, or `Nothing` if the sale fails
pub fun try-vend(price : int, paid : int) : maybe<int>
  try({ vend(price, paid) }).maybe

// vend-or-refund(price, paid) -> the change from `paid` coins, or `paid` if the sale fails
pub fun vend-or-refund(price : int, paid : int) : int
  try(fn(_) paid) { vend(price, paid) }

// panel-text(price, paid) -> "change: <change>", or "error: <message>" if the sale fails
pub fun panel-text(price : int, paid : int) : string
  match try({ vend(price, paid) })
    Ok(change) -> "change: " ++ change.show
    Error(err) -> "error: " ++ err.message

// vend-all(prices, paid) -> the change after buying every item of `prices` in order; throws "not enough money"
// if the coins run out
pub fun vend-all(prices : list<int>, paid : int) : exn int
  prices.foldl(paid) fn(coins, price)
    vend(price, coins)
