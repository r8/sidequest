import std/num/random

fun letter(n : int) : char
  ('a'.int + n % 26).char

fun index(c : char) : int
  c.int - 'a'.int

// random-key() -> a key of at least 100 random lowercase letters, drawn with the `random` effect
pub fun random-key() : <random,exn> string
  list(1, 100).map(fn(_) letter(random-int())).string

// Shifts each letter of `text` by the matching letter of the (repeated) `key`, in direction `dir`.
fun shift(key : string, text : string, dir : int) : exn string
  val keys = key.repeat(text.count / key.count + 1).list
  zip(text.list, keys).map(fn((c, k)) letter(c.index + dir * k.index)).string

// encode(key, plaintext) -> `plaintext` (lowercase letters) with each letter shifted forward by the
// corresponding letter of `key` ('a' = 0, 'b' = 1, ...), repeating the key as needed
pub fun encode(key : string, plaintext : string) : exn string
  shift(key, plaintext, 1)

// decode(key, ciphertext) -> the plaintext that `encode(key, plaintext)` turned into `ciphertext`
pub fun decode(key : string, ciphertext : string) : exn string
  shift(key, ciphertext, -1)
