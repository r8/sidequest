// A time of day, without a date. Clocks made by the functions below are normalized
// (0 <= hour < 24, 0 <= minute < 60), so clocks showing the same time are `==`.
pub struct clock
  hour : int
  minute : int

pub fun show(c : clock) : string
  "Clock(" ++ c.hour.show ++ ", " ++ c.minute.show ++ ")"

pub fun (==)(c : clock, d : clock) : bool
  c.hour == d.hour && c.minute == d.minute

// create(hour, minute) -> the clock showing `hour`:`minute`, rolled over into a single day;
// either may be negative or out of range
pub fun create(hour : int, minute : int) : exn clock
  throw("implement me", ExnTodo)

// add(c, minutes) -> the clock `minutes` minutes later than `c`
pub fun add(c : clock, minutes : int) : exn clock
  throw("implement me", ExnTodo)

// subtract(c, minutes) -> the clock `minutes` minutes earlier than `c`
pub fun subtract(c : clock, minutes : int) : exn clock
  throw("implement me", ExnTodo)

// to-string(c) -> the time as "HH:MM"
pub fun to-string(c : clock) : exn string
  throw("implement me", ExnTodo)
