// clean(phrase) -> the 10-digit NANP number in `phrase`, without punctuation or the country code 1;
// throws "letters not permitted", "punctuations not permitted", "must not be fewer than 10 digits",
// "must not be greater than 11 digits", "11 digits must start with 1",
// "area code cannot start with zero" / "... one", or "exchange code cannot start with zero" / "... one"
pub fun clean(phrase : string) : exn string
  throw("implement me", ExnTodo)
