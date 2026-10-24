// postage(weight, express) -> the postage in euros for a parcel of `weight` kg, sent by express if `express`
pub fun postage(weight : int, express : bool = False) : int
  val standard = 5 + 2 * weight
  if express then standard * 2 else standard

// is-oversize(length, width, height) -> whether a parcel of these sizes in cm is oversized
pub fun is-oversize(length : int, width : int, height : int) : bool
  fun girth() : int
    2 * (width + height)
  length + girth() > 300

// parcel-cost(weight, length, width, height, express) -> what sending the parcel costs in euros
pub fun parcel-cost(weight : int, length : int, width : int, height : int, express : bool = False) : int
  val surcharge = if is-oversize(length, width, height) then 15 else 0
  weight.postage(express = express) + surcharge

// refund(paid, weight) -> how much was overpaid for a standard parcel of `weight` kg when `paid` euros were paid
pub fun refund(paid : int, weight : int) : int
  (paid - weight.postage).max(0)
