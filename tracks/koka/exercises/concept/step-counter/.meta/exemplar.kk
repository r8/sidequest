// total-steps(days) -> the sum of the daily step counts `days`
pub fun total-steps(days : list<int>) : int
  var total := 0
  days.foreach fn(steps)
    total := total + steps
  total

// goal-days(days, goal) -> on how many of `days` at least `goal` steps were walked
pub fun goal-days(days : list<int>, goal : int) : int
  var count := 0
  days.foreach fn(steps)
    if steps >= goal then count := count + 1
  count

// longest-streak(days, goal) -> the length of the longest run of consecutive days that met `goal`
pub fun longest-streak(days : list<int>, goal : int) : int
  var current := 0
  var longest := 0
  days.foreach fn(steps)
    if steps >= goal then
      current := current + 1
      if current > longest then longest := current
    else
      current := 0
  longest

// best-day(days) -> the number (from 1) of the earliest day with the most steps, or 0 without days
pub fun best-day(days : list<int>) : int
  var best := 0
  var record := -1
  days.foreach-indexed fn(i, steps)
    if steps > record then
      record := steps
      best := i + 1
  best

// weeks-to-goal(steps, increase, goal) -> after how many weeks of adding `increase` to `steps` they reach `goal`
pub fun weeks-to-goal(steps : int, increase : int, goal : int) : div int
  var daily := steps
  var weeks := 0
  while { daily < goal }
    daily := daily + increase
    weeks := weeks + 1
  weeks
