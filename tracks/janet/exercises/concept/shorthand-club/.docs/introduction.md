# Introduction

A function receives the _values_ of its arguments: by the time it runs, `(f (+ 1 2))` has already become `(f 3)`.
A _macro_ receives the arguments' _code_, unevaluated, and returns new code that the compiler compiles in place of the macro call.
Macros run at compile time, before the program does, and they let you add your own syntax to the language.
Many things you use every day are macros: `defn`, `when`, `unless`, `cond`, `case`, `->`, `each`, `defer`.

## `defmacro`

`defmacro` looks like `defn`, but what it returns is a form — usually built with quasiquote.

```janet
(defmacro my-unless
  "(my-unless condition & body) -> runs body when condition is falsey"
  [condition & body]
  ~(if ,condition nil (do ,;body)))

(my-unless false
  (print "printed")
  :done)
# => :done
```

When the compiler meets `(my-unless false (print "printed") :done)`, it calls the macro with `condition` bound to the symbol `false` and `body` bound to the tuple of the two remaining forms.
The macro returns `(if false nil (do (print "printed") :done))`, and that is what gets compiled and run.

A macro cannot be implemented as a function here: a function `my-unless` would receive the _result_ of `(print "printed")`, so the printing would already have happened, whatever the condition.

## Seeing an expansion

`macex1` expands the outermost macro of a quoted form, and `macex` expands all of them, so you can check what your macro writes:

```janet
(macex1 '(my-unless ready? (launch)))
# => (if ready? nil (do (launch)))
```

## Code is just data

The arguments a macro receives are the same values you met with quoting: symbols, numbers, strings, tuples.
A macro can inspect them, rearrange them, and quote them:

```janet
(defmacro label [form]
  ~(string ,(string/format "%q" form) " is " ,form))

(label (+ 1 2))
# => "(+ 1 2) is 3"
```

Here the macro turns the form itself into a string at compile time, and also puts the form in the expansion so it is evaluated at run time.
Putting `'` before an unquote, as in `',form`, inserts the form quoted: at run time it is the code as data, not its value.

A macro can also expand to a definition: `(defmacro defconst [name value] ~(def ,name ,value))` makes `(defconst answer 42)` define `answer`.

## Evaluate arguments once

A macro that puts the same argument into its expansion twice makes it run twice:

```janet
(defmacro sq [x] ~(* ,x ,x))

(sq (do (print "computing") 3))
# prints "computing" twice, returns 9
```

That is wrong when the argument has side effects or is expensive.
Bind it once to a local name in the expansion, and use the name.

## Hygiene and `gensym`

Which name?
If the macro writes `(def tmp ,x)`, a caller who happens to have their own `tmp` gets a surprise: the expansion's `tmp` shadows theirs, and `(sq tmp)` would become `(do (def tmp tmp) …)`, which no longer refers to the caller's variable at all.
The fix is a name that cannot clash with anything: `(gensym)` returns a fresh symbol every time it is called.

```janet
(defmacro sq [x]
  (def v (gensym))
  ~(do (def ,v ,x) (* ,v ,v)))

(macex1 '(sq (f)))
# => (do (def _00001 (f)) (* _00001 _00001))
```

`with-syms` is a shorthand: `(with-syms [v] …)` binds `v` to a gensym for the body.

## Symbols in the expansion

The symbols a macro writes into its expansion are looked up where the macro is _used_, not where it is defined.
Core names like `if` and `+` are available everywhere, but a helper function defined next to the macro, in another module, is not; a macro that writes `(helper ,x)` fails with "unknown symbol helper" in its users' code.
Unquote the helper to put the function value itself into the expansion: `~(,helper ,x)`.

## When to write a macro

Write a function whenever a function will do.
Reach for a macro only when you need control over evaluation — skipping, repeating or delaying the arguments — or need to introduce new definitions or syntax.
