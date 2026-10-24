// A ledger keeps a running balance. It is a named effect: every handler of it is a value of type
// `ev<ledger>`, so a program can keep several ledgers at once and say which one it means.
pub named effect ledger
  // record(amount) adds `amount` to the balance; a negative amount takes money out
  fun record(amount : int) : ()
  // balance() is the current balance
  fun balance() : int

// open-ledger(opening, action) -> the result of `action`, given a new ledger whose balance starts at `opening`
pub fun open-ledger(opening : int, action : (ev<ledger>) -> e a) : e a
  var total := opening
  with l <- named handler
    fun record(amount) total := total + amount
    fun balance() total
  action(l)

// transfer(from, to, amount) -> moves `amount` from the ledger `from` to the ledger `to`
pub fun transfer(from : ev<ledger>, to : ev<ledger>, amount : int) : exn ()
  from.record(~amount)
  to.record(amount)

// bank-takings(till, safe, float) -> moves everything in `till` above `float` into `safe`, returning the amount moved
pub fun bank-takings(till : ev<ledger>, safe : ev<ledger>, float : int) : exn int
  val takings = max(0, till.balance - float)
  transfer(till, safe, takings)
  takings

// audit(ledgers) -> the sum of the balances of `ledgers`
pub fun audit(ledgers : list<ev<ledger>>) : exn int
  ledgers.foldl(0, fn(total, l) total + l.balance)

// closing-balance(opening, action) -> the result of `action`, given a new ledger that starts at `opening`, paired with that ledger's final balance
pub fun closing-balance(opening : int, action : (ev<ledger>) -> e a) : e (a, int)
  var total := opening
  with l <- named handler
    return(x) (x, total)
    fun record(amount) total := total + amount
    fun balance() total
  action(l)
