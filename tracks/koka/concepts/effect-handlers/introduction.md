# Introduction

A handler gives the operations of an effect their meaning for one computation. `with handler` handles the rest of
the block, with one clause per operation; for a single operation the keyword can go:

```koka
fun demo() : console string
  with handler
    fun brightness() 30
    fun dim(by) ()
  with fun log(message) println("> " ++ message)
  with val room = "attic"
  log("starting")
  reading-light()
```

A `fun` clause's result is what the operation returns at its call site. The handler removes the effect from the
type. Wrapping a handler in a function, `fun fixed-lamp(level : int, action : () -> <lamp|e> a) : e a`, lets the
same code run against different implementations. A clause runs in the handler's own context: operations it
performs go to the handlers further out, and `with override fun op(…)` lets a clause call the operation it
handles.
