// check-bottles(bottles) -> `Right(bottles)` if a traveller may bring that many, else `Left` with the problem
pub fun check-bottles(bottles : int) : exn either<string,int>
  throw("implement me", ExnTodo)

// check-cash(cash) -> `Right(cash)` if it need not be declared, else `Left` with the problem
pub fun check-cash(cash : int) : exn either<string,int>
  throw("implement me", ExnTodo)

// read-amount(text) -> `Right` with the number `text` spells, else `Left("unreadable: <text>")`
pub fun read-amount(text : string) : exn either<string,int>
  throw("implement me", ExnTodo)

// check-declaration(bottles, cash) -> `Right((bottles, cash))` if both checks pass, else the first problem
pub fun check-declaration(bottles : int, cash : int) : exn either<string,(int,int)>
  throw("implement me", ExnTodo)

// verdict(result) -> what to tell a traveller whose declaration was checked with `result`
pub fun verdict(result : either<string,(int,int)>) : exn string
  throw("implement me", ExnTodo)
