fun check-start(digit : char, part : string) : exn ()
  match digit
    '0' -> throw(part ++ " cannot start with zero")
    '1' -> throw(part ++ " cannot start with one")
    _   -> ()

// clean(phrase) -> the 10-digit NANP number in `phrase`, without punctuation or the country code 1;
// throws "letters not permitted", "punctuations not permitted", "must not be fewer than 10 digits",
// "must not be greater than 11 digits", "11 digits must start with 1",
// "area code cannot start with zero" / "... one", or "exchange code cannot start with zero" / "... one"
pub fun clean(phrase : string) : exn string
  val chars = phrase.list
  if chars.any(is-alpha) then throw("letters not permitted")
  if chars.any(fn(c) !c.is-digit && !" ()-.+".list.any(fn(p) p == c)) then
    throw("punctuations not permitted")
  val digits = chars.filter(is-digit)
  val number = match digits.length
    10 -> digits
    11 -> match digits
      Cons('1', rest) -> rest
      _ -> throw("11 digits must start with 1")
    n -> if n < 10 then throw("must not be fewer than 10 digits")
         else throw("must not be greater than 11 digits")
  check-start(number[0].default(' '), "area code")
  check-start(number[3].default(' '), "exchange code")
  number.string
