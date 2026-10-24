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
pub fun new-bike(number : int, model : string) : bike
  Bike(number, model)

// is-available(b) -> whether nobody is riding `b`
pub fun is-available(b : bike) : bool
  b.rider.is-empty

// rent(b, rider) -> `b` while `rider` is riding it
pub fun rent(b : bike, rider : string) : bike
  b(rider = rider)

// return-bike(b, ridden) -> `b` back in the shed, after a ride of `ridden` kilometres
pub fun return-bike(b : bike, ridden : int) : bike
  b(rider = "", km = b.km + ridden)

// tag(b) -> the text on `b`'s tag: "#<number> <model>, <km> km", then ", out with <rider>" if it is out
pub fun tag(b : bike) : string
  val base = "#" ++ b.number.show ++ " " ++ b.model ++ ", " ++ b.km.show ++ " km"
  if b.is-available then base else base ++ ", out with " ++ b.rider
