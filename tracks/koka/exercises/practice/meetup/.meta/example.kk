// Which week of the month a meetup is in.
pub type week
  First
  Second
  Third
  Fourth
  Last
  Teenth

pub fun week/(==)(a : week, b : week) : bool
  a.show == b.show

pub fun week/show(w : week) : string
  match w
    First -> "First"
    Second -> "Second"
    Third -> "Third"
    Fourth -> "Fourth"
    Last -> "Last"
    Teenth -> "Teenth"

// The days of the week.
pub type weekday
  Monday
  Tuesday
  Wednesday
  Thursday
  Friday
  Saturday
  Sunday

pub fun weekday/(==)(a : weekday, b : weekday) : bool
  a.show == b.show

pub fun weekday/show(d : weekday) : string
  match d
    Monday -> "Monday"
    Tuesday -> "Tuesday"
    Wednesday -> "Wednesday"
    Thursday -> "Thursday"
    Friday -> "Friday"
    Saturday -> "Saturday"
    Sunday -> "Sunday"

fun leap-year(year : int) : bool
  year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

fun days-in-month(year : int, month : int) : int
  match month
    2 -> if leap-year(year) then 29 else 28
    4 -> 30
    6 -> 30
    9 -> 30
    11 -> 30
    _ -> 31

// The day of the week of a date, 0 for Sunday up to 6 for Saturday (Sakamoto's method).
fun day-of-week(year : int, month : int, day : int) : int
  val offsets = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
  val y = if month < 3 then year - 1 else year
  (y + y / 4 - y / 100 + y / 400 + offsets[month - 1].default(0) + day) % 7

fun index(d : weekday) : int
  match d
    Sunday -> 0
    Monday -> 1
    Tuesday -> 2
    Wednesday -> 3
    Thursday -> 4
    Friday -> 5
    Saturday -> 6

// meetup(year, month, week, weekday) -> the date of the meetup as a (year, month, day) tuple,
// for example (2013, 5, 13) for the teenth Monday of May 2013
pub fun meetup(year : int, month : int, week : week, weekday : weekday) : (int, int, int)
  // the first day of the seven-day window the meetup falls in
  val start = match week
    First -> 1
    Second -> 8
    Third -> 15
    Fourth -> 22
    Teenth -> 13
    Last -> days-in-month(year, month) - 6
  (year, month, start + (weekday.index - day-of-week(year, month, start)) % 7)
