val ones = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
            "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
            "eighteen", "nineteen"]

val tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

val scales = [(1_000_000_000, " billion"), (1_000_000, " million"), (1_000, " thousand"), (1, "")]

fun below-hundred(n : int) : string
  if n < 20 then ones[n].default("")
  else tens[n / 10].default("") ++ (if n % 10 == 0 then "" else "-" ++ ones[n % 10].default(""))

fun below-thousand(n : int) : string
  if n < 100 then below-hundred(n)
  else ones[n / 100].default("") ++ " hundred" ++ (if n % 100 == 0 then "" else " " ++ below-hundred(n % 100))

// say(number) -> `number` in English words; throws "input out of range" unless 0 <= number < 10^12
pub fun say(number : int) : exn string
  if number < 0 || number > 999_999_999_999 then throw("input out of range")
  if number == 0 then return "zero"
  scales.filter-map(fn(scale)
    val chunk = (number / scale.fst) % 1000
    if chunk == 0 then Nothing else Just(below-thousand(chunk) ++ scale.snd)
  ).join(" ")
