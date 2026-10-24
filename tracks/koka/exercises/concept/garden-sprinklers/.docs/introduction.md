# Introduction

## Nesting lambdas

Trailing lambdas make a higher-order call read like a block of code:

```koka
fun print-grid(rows : int, cols : int) : console ()
  for(1, rows) fn(r)
    for(1, cols) fn(c)
      println(r.show ++ "," ++ c.show)
```

Each extra level indents the code further, even though the reading order is simple: "for every row, for every
column, print". Koka's `with` statement writes the same thing flat.

## `with` passes the rest of the block

`with` followed by a call takes _all the statements below it in the same block_, wraps them in a function, and
passes that function as the call's last argument. There are two forms. Without a binding,

```koka
with f(e1, e2)
rest
```

means `f(e1, e2, fn() { rest })`. With a binding,

```koka
with x <- f(e1, e2)
rest
```

means `f(e1, e2, fn(x) { rest })`: the name before `<-` becomes the lambda's parameter. So `print-grid` becomes

```koka
fun print-grid(rows : int, cols : int) : console ()
  with r <- for(1, rows)
  with c <- for(1, cols)
  println(r.show ++ "," ++ c.show)
```

Several `with` statements nest in order: the first one is the outermost call. A call without arguments drops the
parentheses, as anywhere else:

```koka
fun twice(action : () -> e ()) : e ()
  action()
  action()

fun cheer() : console ()
  with twice
  println("hip hip")
  println("hooray")
```

`cheer` prints both lines, then both lines again: everything below `with twice` is the action.

`with` is not tied to library functions. It works with any function whose last parameter is a function,
including the ones you write, which makes it a cheap way to build your own control structures.

## The rest of the block means all of it

The function `with` builds runs to the end of the enclosing block, so a statement placed after the body still
belongs to it. This does not do what it looks like:

```koka
fun shout-twice(word : string) : console ()
  with twice
  println(word)
  println("done")     // printed twice as well
```

To stop the `with` early, put it in a block of its own. A trailing lambda gives you one:

```koka
fun count-up(xs : list<int>) : int
  var total := 0
  xs.foreach fn(x)
    with twice
    total := total + x
  total               // after the foreach, not inside it
```

For a body of a single expression, `with … in` keeps it on one line: `with twice in total := total + 1`.

## Bindings are names

The binding before `<-` is a single name, not a pattern. To take a tuple apart, bind it to a name and
destructure it on the next line:

```koka
fun shout-all(pairs : list<(string, int)>) : console ()
  with pair <- pairs.foreach
  val (word, n) = pair
  println(word.to-upper ++ " " ++ n.show)
```

## Where `with` is heading

`with` is only syntax: the code it produces is an ordinary call with a trailing lambda. It earns its keep with
functions that take "the rest of the computation" as their argument. The next lessons, on effect handlers, use
it constantly: a handler is exactly such a function, and `with handler …` installs one over the rest of a block.
