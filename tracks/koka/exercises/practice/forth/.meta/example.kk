// A step of a program: push a number, or run a built-in word.
type op
  Push(n : int)
  Builtin(name : string)

alias dictionary = list<(string, list<op>)>

val builtins = ["+", "-", "*", "/", "dup", "drop", "swap", "over"]

// The top two values of the stack (top first), as (second, top, rest).
fun top-two(stack : list<int>) : exn (int, int, list<int>)
  match stack
    Cons(b, Cons(a, rest)) -> (a, b, rest)
    Cons(_, Nil) -> throw("only one value on the stack")
    Nil -> throw("empty stack")

// Replaces the top two values of the stack with `f` applied to them.
fun binary(stack : list<int>, f : (int, int) -> exn int) : exn list<int>
  val (a, b, rest) = top-two(stack)
  Cons(f(a, b), rest)

// `a` divided by `b`, rounded toward zero. Koka's `/` is Euclidean, which rounds -7 / -2 up to 4.
fun quotient(a : int, b : int) : int
  val q = a.abs / b.abs
  if (a < 0) == (b < 0) then q else ~q

fun run-builtin(stack : list<int>, name : string) : exn list<int>
  match name
    "+" -> stack.binary(fn(a, b) a + b)
    "-" -> stack.binary(fn(a, b) a - b)
    "*" -> stack.binary(fn(a, b) a * b)
    "/" -> stack.binary(fn(a, b) if b == 0 then throw("divide by zero") else quotient(a, b))
    "dup" -> match stack
      Cons(a, _) -> Cons(a, stack)
      Nil -> throw("empty stack")
    "drop" -> match stack
      Cons(_, rest) -> rest
      Nil -> throw("empty stack")
    "swap" ->
      val (a, b, rest) = top-two(stack)
      Cons(a, Cons(b, rest))
    "over" ->
      val (a, _, _) = top-two(stack)
      Cons(a, stack)
    _ -> throw("undefined operation")

fun run-op(stack : list<int>, op : op) : exn list<int>
  match op
    Push(n) -> Cons(n, stack)
    Builtin(name) -> stack.run-builtin(name)

// The ops a word stands for: a user definition first, then a number or a built-in.
fun expand(dict : dictionary, word : string) : exn list<op>
  match dict.lookup(fn(name) name == word)
    Just(ops) -> ops
    Nothing -> match word.parse-int
      Just(n) -> [Push(n)]
      Nothing -> if builtins.contains(word) then [Builtin(word)] else throw("undefined operation")

// Runs one line, returning the new dictionary and stack.
fun run-line((dict, stack) : (dictionary, list<int>), line : string) : exn (dictionary, list<int>)
  // Words are separated by any whitespace, not only spaces.
  val words = line.to-lower.map(fn(c) if c.is-white then ' ' else c).split(" ").filter(is-notempty)
  match words
    Cons(":", Cons(name, rest)) ->
      if name.parse-int.is-just then throw("illegal operation")
      val body = rest.take-while(fn(w) w != ";").flatmap(fn(w) dict.expand(w))
      (Cons((name, body), dict), stack)
    _ -> (dict, words.flatmap(fn(w) dict.expand(w)).foldl(stack, run-op))

// evaluate(instructions) -> the stack, bottom first, after running each line of Forth in turn;
// throws "empty stack", "only one value on the stack", "divide by zero", "illegal operation"
// or "undefined operation" when a line can't run
pub fun evaluate(instructions : list<string>) : exn list<int>
  instructions.foldl(([], []), run-line).snd.reverse
