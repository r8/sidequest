import std/num/float64

// trays-needed(rolls) -> how many trays of 12 it takes to bake `rolls` rolls
pub fun trays-needed(rolls : int) : exn int
  throw("implement me", ExnTodo)

// spare-places(rolls) -> how many places are left empty on the trays when baking `rolls` rolls
pub fun spare-places(rolls : int) : exn int
  throw("implement me", ExnTodo)

// flour-kg(rolls) -> the kilograms of flour that `rolls` rolls take
pub fun flour-kg(rolls : int) : exn float64
  throw("implement me", ExnTodo)

// daily-average(rolls, days) -> the rolls sold per day on average, when `rolls` were sold in `days` days
pub fun daily-average(rolls : int, days : int) : exn float64
  throw("implement me", ExnTodo)

// order-price(rolls) -> the price of `rolls` rolls in whole euros, rounded up
pub fun order-price(rolls : int) : exn int
  throw("implement me", ExnTodo)
