// empty-row(seats) -> a row of `seats` seats, none of them booked
pub fun empty-row(seats : int) : vector<bool>
  vector(seats, False)

// seat-prices(seats, base) -> the price of each of `seats` seats: seat i costs `base` + i
pub fun seat-prices(seats : int, base : int) : vector<int>
  vector-init(seats) fn(i)
    base + i

// is-free(row, seat) -> whether seat `seat` exists in `row` and is not booked
pub fun is-free(row : vector<bool>, seat : int) : bool
  if seat < 0 then False
  else match row.at(seat)
    Just(booked) -> !booked
    Nothing -> False

// book(row, seat) -> `row` with seat `seat` booked; throws "index out of bounds" past the end of the row
pub fun book(row : vector<bool>, seat : int) : exn vector<bool>
  var booked := row
  booked[seat] := True
  booked

// free-count(row) -> how many seats of `row` are free
pub fun free-count(row : vector<bool>) : int
  var count := 0
  row.foreach fn(booked)
    if !booked then count := count + 1
  count
