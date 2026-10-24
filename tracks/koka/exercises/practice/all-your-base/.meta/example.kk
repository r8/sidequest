fun to-digits(n : int, base : int, acc : list<int> = []) : div list<int>
  if n < base then Cons(n, acc) else to-digits(n / base, base, Cons(n % base, acc))

// rebase(input-base, digits, output-base) -> the digits, most significant first, of the number
// whose digits in `input-base` are `digits`, written in `output-base`; zero is [0].
// Throws "input base must be >= 2", "output base must be >= 2" or
// "all digits must satisfy 0 <= d < input base"
pub fun rebase(input-base : int, digits : list<int>, output-base : int) : <div,exn> list<int>
  if input-base < 2 then throw("input base must be >= 2")
  if output-base < 2 then throw("output base must be >= 2")
  if digits.any(fn(d) d < 0 || d >= input-base) then throw("all digits must satisfy 0 <= d < input base")
  digits.foldl(0, fn(n, d) n * input-base + d).to-digits(output-base)
