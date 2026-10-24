val numerals = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"),
                (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]

// roman(number) -> `number` written in Roman numerals
pub fun roman(number : int) : string
  val (result, _) = numerals.foldl(("", number)) fn(acc, numeral)
    val (out, rest) = acc
    val (value, symbol) = numeral
    (out ++ symbol.repeat(rest / value), rest % value)
  result
