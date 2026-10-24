// encode(text) -> `text` with each run of a repeated character replaced by its length and the character
// ("AABCCC" -> "2AB3C"); single characters keep no count
pub fun encode(text : string) : exn string
  throw("implement me", ExnTodo)

// decode(text) -> the original string of the run-length encoded `text` ("2AB3C" -> "AABCCC")
pub fun decode(text : string) : exn string
  throw("implement me", ExnTodo)
