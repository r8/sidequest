// ciphertext(plaintext) -> the crypto square encoding of `plaintext`: its lowercased letters and digits written
// in rows of c characters (the smallest rectangle r x c with c >= r and c - r <= 1, padded with spaces),
// then read down the columns, joined by single spaces
pub fun ciphertext(plaintext : string) : exn string
  throw("implement me", ExnTodo)
