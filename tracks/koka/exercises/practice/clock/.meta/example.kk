// A time of day, without a date. Clocks made by the functions below are normalized
// (0 <= hour < 24, 0 <= minute < 60), so clocks showing the same time are `==`.
pub struct clock
  hour : int
  minute : int

pub fun show(c : clock) : string
  "Clock(" ++ c.hour.show ++ ", " ++ c.minute.show ++ ")"

pub fun (==)(c : clock, d : clock) : bool
  c.hour == d.hour && c.minute == d.minute

val minutes-per-day = 24 * 60

// create(hour, minute) -> the clock showing `hour`:`minute`, rolled over into a single day;
// either may be negative or out of range
pub fun create(hour : int, minute : int) : clock
  // Koka's % is Euclidean: the remainder is never negative.
  val m = (hour * 60 + minute) % minutes-per-day
  Clock(m / 60, m % 60)

// add(c, minutes) -> the clock `minutes` minutes later than `c`
pub fun add(c : clock, minutes : int) : clock
  create(c.hour, c.minute + minutes)

// subtract(c, minutes) -> the clock `minutes` minutes earlier than `c`
pub fun subtract(c : clock, minutes : int) : clock
  c.add(~minutes)

fun two-digits(n : int) : string
  n.show.pad-left(2, '0')

// to-string(c) -> the time as "HH:MM"
pub fun to-string(c : clock) : string
  c.hour.two-digits ++ ":" ++ c.minute.two-digits
