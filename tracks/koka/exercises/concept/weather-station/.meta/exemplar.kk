// The temperature at a weather station, by name.
pub effect sensor
  fun reading(station : string) : int

// The suffix printed after a temperature, such as "C".
pub effect val units : string

// difference(a, b) -> the reading of station `a` minus the reading of station `b`
pub fun difference(a : string, b : string) : sensor int
  reading(a) - reading(b)

// average(stations) -> the average reading of `stations`, rounded down; 0 without stations
pub fun average(stations : list<string>) : sensor int
  stations.map(reading).sum / stations.length

// report(station) -> "<station>: <reading><units>"
pub fun report(station : string) : <sensor,units> string
  station ++ ": " ++ reading(station).show ++ units

// with-readings(table, action) -> runs `action` with every reading taken from `table`, 0 for a missing station
pub fun with-readings(table : list<(string, int)>, action : () -> <sensor|e> a) : e a
  with fun reading(station) table.lookup(fn(name) name == station).default(0)
  action()

// with-offset(delta, action) -> runs `action` with every reading of the outer sensor handler increased by `delta`
pub fun with-offset(delta : int, action : () -> <sensor|e> a) : <sensor|e> a
  with override fun reading(station) reading(station) + delta
  action()
