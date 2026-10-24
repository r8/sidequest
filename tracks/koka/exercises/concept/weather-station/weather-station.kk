// The temperature at a weather station, by name.
pub effect sensor
  fun reading(station : string) : int

// The suffix printed after a temperature, such as "C".
pub effect val units : string

// difference(a, b) -> the reading of station `a` minus the reading of station `b`
pub fun difference(a : string, b : string) : <sensor,exn> int
  throw("implement me", ExnTodo)

// average(stations) -> the average reading of `stations`, rounded down; 0 without stations
pub fun average(stations : list<string>) : <sensor,exn> int
  throw("implement me", ExnTodo)

// report(station) -> "<station>: <reading><units>"
pub fun report(station : string) : <sensor,units,exn> string
  throw("implement me", ExnTodo)

// with-readings(table, action) -> runs `action` with every reading taken from `table`, 0 for a missing station
pub fun with-readings(table : list<(string, int)>, action : () -> <sensor,exn|e> a) : <exn|e> a
  throw("implement me", ExnTodo)

// with-offset(delta, action) -> runs `action` with every reading of the outer sensor handler increased by `delta`
pub fun with-offset(delta : int, action : () -> <sensor,exn|e> a) : <sensor,exn|e> a
  throw("implement me", ExnTodo)
