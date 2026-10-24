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

// meetup(year, month, week, weekday) -> the date of the meetup as a (year, month, day) tuple,
// for example (2013, 5, 13) for the teenth Monday of May 2013
pub fun meetup(year : int, month : int, week : week, weekday : weekday) : exn (int, int, int)
  throw("implement me", ExnTodo)
