// is-night(hour) -> whether `hour` (0 to 23) is a night hour, from 22:00 until 6:00
pub fun is-night(hour : int) : bool
  hour >= 22 || hour < 6

// can-board(has-ticket, has-pass, is-banned) -> whether a passenger may board the train
pub fun can-board(has-ticket : bool, has-pass : bool, is-banned : bool) : bool
  (has-ticket || has-pass) && !is-banned

// fare(age) -> the fare in euros for a passenger of `age` years
pub fun fare(age : int) : int
  if age < 4 then 0
  elif age < 16 then 20
  elif age >= 65 then 25
  else 40

// ticket-price(age, sleeper) -> the price of a ticket for a passenger of `age` years, with a sleeper berth if `sleeper`
pub fun ticket-price(age : int, sleeper : bool) : int
  fare(age) + (if sleeper then 30 else 0)
