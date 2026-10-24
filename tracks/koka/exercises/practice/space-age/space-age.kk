// The eight planets of the Solar System.
pub type planet
  Mercury
  Venus
  Earth
  Mars
  Jupiter
  Saturn
  Uranus
  Neptune

pub fun show(p : planet) : string
  match p
    Mercury -> "Mercury"
    Venus -> "Venus"
    Earth -> "Earth"
    Mars -> "Mars"
    Jupiter -> "Jupiter"
    Saturn -> "Saturn"
    Uranus -> "Uranus"
    Neptune -> "Neptune"

pub fun (==)(p : planet, q : planet) : bool
  p.show == q.show

// age(planet, seconds) -> the age in years of that planet of someone `seconds` seconds old
pub fun age(planet : planet, seconds : int) : exn float64
  throw("implement me", ExnTodo)
