// postage(weight, express) -> the postage in euros for a parcel of `weight` kg, sent by express if `express`
pub fun postage(weight : int, express : bool = False) : exn int
  throw("implement me", ExnTodo)

// is-oversize(length, width, height) -> whether a parcel of these sizes in cm is oversized
pub fun is-oversize(length : int, width : int, height : int) : exn bool
  throw("implement me", ExnTodo)

// parcel-cost(weight, length, width, height, express) -> what sending the parcel costs in euros
pub fun parcel-cost(weight : int, length : int, width : int, height : int, express : bool = False) : exn int
  throw("implement me", ExnTodo)

// refund(paid, weight) -> how much was overpaid for a standard parcel of `weight` kg when `paid` euros were paid
pub fun refund(paid : int, weight : int) : exn int
  throw("implement me", ExnTodo)
