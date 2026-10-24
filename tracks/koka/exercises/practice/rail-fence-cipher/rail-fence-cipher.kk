// encode(msg, rails) -> `msg` written in a zig-zag over `rails` rails, then read off rail by rail
pub fun encode(msg : string, rails : int) : exn string
  throw("implement me", ExnTodo)

// decode(msg, rails) -> the plain text that `encode(plaintext, rails)` turned into `msg`
pub fun decode(msg : string, rails : int) : exn string
  throw("implement me", ExnTodo)
