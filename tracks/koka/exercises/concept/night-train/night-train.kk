// is-night(hour) -> whether `hour` (0 to 23) is a night hour, from 22:00 until 6:00
pub fun is-night(hour : int) : exn bool
  throw("implement me", ExnTodo)

// can-board(has-ticket, has-pass, is-banned) -> whether a passenger may board the train
pub fun can-board(has-ticket : bool, has-pass : bool, is-banned : bool) : exn bool
  throw("implement me", ExnTodo)

// fare(age) -> the fare in euros for a passenger of `age` years
pub fun fare(age : int) : exn int
  throw("implement me", ExnTodo)

// ticket-price(age, sleeper) -> the price of a ticket for a passenger of `age` years, with a sleeper berth if `sleeper`
pub fun ticket-price(age : int, sleeper : bool) : exn int
  throw("implement me", ExnTodo)
