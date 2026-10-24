# Introduction

A Koka module is a file of definitions. `fun` defines a function: its name, its parameters with their types, and
after a colon the type of its result. The body is the indented block below, and its last expression is the result:

```koka
val minutes-per-cup = 2

pub fun boiling-minutes(cups : int) : int
  val minutes = cups * minutes-per-cup
  minutes + 1
```

`val` names a value that never changes. Whole numbers have the type `int` and use `+`, `-` and `*`. Names may
contain dashes, so always put spaces around a minus sign. `pub` makes a definition visible outside its module,
and `//` starts a comment.
