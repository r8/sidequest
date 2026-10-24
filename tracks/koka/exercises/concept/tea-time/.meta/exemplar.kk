val minutes-per-cup = 2

// steep-minutes() -> how many minutes a pot of tea steeps
pub fun steep-minutes() : int
  4

// minutes-left(steeped) -> the minutes left for a pot that has steeped for `steeped` minutes
pub fun minutes-left(steeped : int) : int
  steep-minutes() - steeped

// boiling-minutes(cups) -> the minutes the kettle needs to boil water for `cups` cups
pub fun boiling-minutes(cups : int) : int
  cups * minutes-per-cup

// elapsed-minutes(cups, steeped) -> the minutes spent so far on a pot of `cups` cups that has steeped for `steeped` minutes
pub fun elapsed-minutes(cups : int, steeped : int) : int
  boiling-minutes(cups) + steeped
