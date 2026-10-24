import std/num/random

// random-key() -> a key of at least 100 random lowercase letters, drawn with the `random` effect
pub fun random-key() : <random,exn> string
  throw("implement me", ExnTodo)

// encode(key, plaintext) -> `plaintext` (lowercase letters) with each letter shifted forward by the
// corresponding letter of `key` ('a' = 0, 'b' = 1, ...), repeating the key as needed
pub fun encode(key : string, plaintext : string) : exn string
  throw("implement me", ExnTodo)

// decode(key, ciphertext) -> the plaintext that `encode(key, plaintext)` turned into `ciphertext`
pub fun decode(key : string, ciphertext : string) : exn string
  throw("implement me", ExnTodo)
