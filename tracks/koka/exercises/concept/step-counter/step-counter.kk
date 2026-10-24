// total-steps(days) -> the sum of the daily step counts `days`
pub fun total-steps(days : list<int>) : exn int
  throw("implement me", ExnTodo)

// goal-days(days, goal) -> on how many of `days` at least `goal` steps were walked
pub fun goal-days(days : list<int>, goal : int) : exn int
  throw("implement me", ExnTodo)

// longest-streak(days, goal) -> the length of the longest run of consecutive days that met `goal`
pub fun longest-streak(days : list<int>, goal : int) : exn int
  throw("implement me", ExnTodo)

// best-day(days) -> the number (from 1) of the earliest day with the most steps, or 0 without days
pub fun best-day(days : list<int>) : exn int
  throw("implement me", ExnTodo)

// weeks-to-goal(steps, increase, goal) -> after how many weeks of adding `increase` to `steps` they reach `goal`
pub fun weeks-to-goal(steps : int, increase : int, goal : int) : <div,exn> int
  throw("implement me", ExnTodo)
