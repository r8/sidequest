import std/num/float64

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

val earth-year = 31557600.0

// The planet's orbital period in Earth years.
fun orbital-period(p : planet) : float64
  match p
    Mercury -> 0.2408467
    Venus -> 0.61519726
    Earth -> 1.0
    Mars -> 1.8808158
    Jupiter -> 11.862615
    Saturn -> 29.447498
    Uranus -> 84.016846
    Neptune -> 164.79132

// age(planet, seconds) -> the age in years of that planet of someone `seconds` seconds old
pub fun age(planet : planet, seconds : int) : float64
  seconds.float64 / earth-year / planet.orbital-period
