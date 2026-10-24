fun row(size : int, i : int) : string
  val letter = ('A'.int + i).char.string
  val outer = " ".repeat(size - i)
  val inner = if i == 0 then letter else letter ++ " ".repeat(2 * i - 1) ++ letter
  outer ++ inner ++ outer

// rows(letter) -> the rows of the diamond whose widest row holds `letter`
pub fun rows(letter : char) : list<string>
  val size = letter.int - 'A'.int
  val top = list(0, size).map(fn(i) row(size, i))
  top ++ top.reverse.drop(1)
