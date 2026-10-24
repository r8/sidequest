// ciphertext(plaintext) -> the crypto square encoding of `plaintext`: its lowercased letters and digits written
// in rows of c characters (the smallest rectangle r x c with c >= r and c - r <= 1, padded with spaces),
// then read down the columns, joined by single spaces
pub fun ciphertext(plaintext : string) : exn string
  val text = plaintext.to-lower.list.filter(is-alpha-num)
  val n = text.length
  if n == 0 then return ""
  val c = list(1, n).find(fn(x) x * x >= n).default(n)
  val r = if c * (c - 1) >= n then c - 1 else c
  val padded = text ++ replicate(' ', r * c - n)
  val rows = list(0, r - 1).map(fn(i) padded.drop(i * c).take(c))
  list(0, c - 1).map(fn(j) rows.filter-map(fn(row) row[j]).string).join(" ")
