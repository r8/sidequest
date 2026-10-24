// empty-row(seats) -> a row of `seats` seats, none of them booked
pub fun empty-row(seats : int) : exn vector<bool>
  throw("implement me", ExnTodo)

// seat-prices(seats, base) -> the price of each of `seats` seats: seat i costs `base` + i
pub fun seat-prices(seats : int, base : int) : exn vector<int>
  throw("implement me", ExnTodo)

// is-free(row, seat) -> whether seat `seat` exists in `row` and is not booked
pub fun is-free(row : vector<bool>, seat : int) : exn bool
  throw("implement me", ExnTodo)

// book(row, seat) -> `row` with seat `seat` booked; throws "index out of bounds" past the end of the row
pub fun book(row : vector<bool>, seat : int) : exn vector<bool>
  throw("implement me", ExnTodo)

// free-count(row) -> how many seats of `row` are free
pub fun free-count(row : vector<bool>) : exn int
  throw("implement me", ExnTodo)
