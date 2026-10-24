// check-bottles(bottles) -> `Right(bottles)` if a traveller may bring that many, else `Left` with the problem
pub fun check-bottles(bottles : int) : either<string,int>
  if bottles < 0 then Left("bottles cannot be negative")
  elif bottles > 4 then Left("too many bottles")
  else Right(bottles)

// check-cash(cash) -> `Right(cash)` if it need not be declared, else `Left` with the problem
pub fun check-cash(cash : int) : either<string,int>
  if cash > 10000 then Left("declare cash over 10000") else Right(cash)

// read-amount(text) -> `Right` with the number `text` spells, else `Left("unreadable: <text>")`
pub fun read-amount(text : string) : either<string,int>
  match text.parse-int
    Just(n) -> Right(n)
    Nothing -> Left("unreadable: " ++ text)

// check-declaration(bottles, cash) -> `Right((bottles, cash))` if both checks pass, else the first problem
pub fun check-declaration(bottles : int, cash : int) : either<string,(int,int)>
  match check-bottles(bottles)
    Left(problem) -> Left(problem)
    Right(b) ->
      match check-cash(cash)
        Left(problem) -> Left(problem)
        Right(c) -> Right((b, c))

// verdict(result) -> what to tell a traveller whose declaration was checked with `result`
pub fun verdict(result : either<string,(int,int)>) : string
  match result
    Right -> "Welcome to the island!"
    Left(problem) -> "Please step aside: " ++ problem
