import std/num/float64

val rolls-per-tray = 12
val flour-per-roll = 0.125
val price-per-roll = 0.75

// trays-needed(rolls) -> how many trays of 12 it takes to bake `rolls` rolls
pub fun trays-needed(rolls : int) : int
  (rolls + rolls-per-tray - 1) / rolls-per-tray

// spare-places(rolls) -> how many places are left empty on the trays when baking `rolls` rolls
pub fun spare-places(rolls : int) : int
  trays-needed(rolls) * rolls-per-tray - rolls

// flour-kg(rolls) -> the kilograms of flour that `rolls` rolls take
pub fun flour-kg(rolls : int) : float64
  rolls.float64 * flour-per-roll

// daily-average(rolls, days) -> the rolls sold per day on average, when `rolls` were sold in `days` days
pub fun daily-average(rolls : int, days : int) : float64
  rolls.float64 / days.float64

// order-price(rolls) -> the price of `rolls` rolls in whole euros, rounded up
pub fun order-price(rolls : int) : int
  (rolls.float64 * price-per-roll).ceiling.int
