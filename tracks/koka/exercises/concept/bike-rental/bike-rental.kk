// A bicycle in Rosa's fleet. A bike whose `rider` is empty is in the shed.
pub struct bike
  number : int
  model : string
  rider : string = ""
  km : int = 0

// Shows a bike, as the tests print it.
pub fun show(b : bike) : string
  "Bike(number = " ++ b.number.show ++ ", model = " ++ b.model.show ++ ", rider = " ++ b.rider.show ++
    ", km = " ++ b.km.show ++ ")"

// Whether two bikes are the same in every field.
pub fun (==)(a : bike, b : bike) : bool
  a.number == b.number && a.model == b.model && a.rider == b.rider && a.km == b.km

// new-bike(number, model) -> a bike in the shed that has not been ridden
pub fun new-bike(number : int, model : string) : exn bike
  throw("implement me", ExnTodo)

// is-available(b) -> whether nobody is riding `b`
pub fun is-available(b : bike) : exn bool
  throw("implement me", ExnTodo)

// rent(b, rider) -> `b` while `rider` is riding it
pub fun rent(b : bike, rider : string) : exn bike
  throw("implement me", ExnTodo)

// return-bike(b, ridden) -> `b` back in the shed, after a ride of `ridden` kilometres
pub fun return-bike(b : bike, ridden : int) : exn bike
  throw("implement me", ExnTodo)

// tag(b) -> the text on `b`'s tag: "#<number> <model>, <km> km", then ", out with <rider>" if it is out
pub fun tag(b : bike) : exn string
  throw("implement me", ExnTodo)
