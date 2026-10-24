type token
  Number(value : int)
  Operation(apply : (int, int) -> exn int)

// `a` divided by `b`, rounded toward zero. Koka's `/` is Euclidean, which rounds -7 / -2 up to 4.
fun quotient(a : int, b : int) : exn int
  if b == 0 then throw("division by zero")
  val q = a.abs / b.abs
  if (a < 0) == (b < 0) then q else ~q

fun tokenize(words : list<string>) : exn list<token>
  match words
    Nil -> Nil
    Cons("plus", rest) -> Cons(Operation(fn(a, b) a + b), tokenize(rest))
    Cons("minus", rest) -> Cons(Operation(fn(a, b) a - b), tokenize(rest))
    Cons("multiplied", Cons("by", rest)) -> Cons(Operation(fn(a, b) a * b), tokenize(rest))
    Cons("divided", Cons("by", rest)) -> Cons(Operation(quotient), tokenize(rest))
    Cons(word, rest) -> match word.parse-int
      Just(n) -> Cons(Number(n), tokenize(rest))
      Nothing -> throw("unknown operation")

fun evaluate(total : int, tokens : list<token>) : exn int
  match tokens
    Nil -> total
    Cons(Operation(op), Cons(Number(n), rest)) -> evaluate(op(total, n), rest)
    _ -> throw("syntax error")

// answer(question) -> the value of a "What is ...?" word problem; throws "unknown operation",
// "syntax error" or "division by zero"
pub fun answer(question : string) : exn int
  val body = match question.starts-with("What is")
    Just(rest) -> rest.string
    Nothing -> throw("unknown operation")
  val words = match body.ends-with("?")
    Just(rest) -> rest.string.split(" ").filter(fn(w) !w.is-empty)
    Nothing -> throw("syntax error")
  match tokenize(words)
    Cons(Number(n), rest) -> evaluate(n, rest)
    _ -> throw("syntax error")
