# About

## How expansion works

The compiler reads a form; when its head is a symbol bound to a macro, it calls the macro with the rest of the form, unevaluated, and compiles whatever the macro returns instead — repeating until no macros remain.
A macro is an ordinary Janet function marked as a macro, so it can use the whole language: loops, tables, string functions, PEGs.
It runs once per call site, at compile time; the code it returns runs every time the call site is reached.

`defmacro` is `defn` for macros: name, docstring, parameters (including `&` and `&opt`), body.
Its result is usually built with quasiquote: `~` for the template, `,` to insert an argument, `,;` to splice a body.

## Inspecting expansions

- `(macex1 form)` expands the outermost macro once.
- `(macex form)` expands repeatedly until no macros are left anywhere in the form.
- `(doc name)` shows a macro's docstring and marks it as a macro.

Expanding a macro by hand is the fastest way to debug it.

## Hygiene

Janet macros are not automatically hygienic: the symbols an expansion contains mean whatever they mean at the call site.

- **Capturing the caller's names.** An expansion that introduces `(def tmp …)` shadows a caller's `tmp`. Use `(gensym)`, or `(with-syms [tmp] …)`, for every name the macro introduces.
- **Losing the macro's own names.** An expansion that calls `helper` fails where `helper` is not in scope (for example in another module, or where it is shadowed). Unquote the function value instead: `~(,helper ,x)`. Core functions and special forms are visible everywhere and can stay as symbols, though a careful macro unquotes them too in case the caller has shadowed them.

## Evaluating arguments once

A macro argument is code; mentioning it twice in the expansion runs it twice.
Bind it once:

```janet
(defmacro sq [x]
  (with-syms [v]
    ~(do (def ,v ,x) (* ,v ,v))))
```

## Common shapes

- Control flow: `when`, `unless`, `cond`, `case`, `and`, `or` are macros over `if` and `do`.
- Binding: `let`, `if-let`, `with`, `with-dyns`, `defer` wrap a body in setup and teardown.
- Definition: `defn`, `defmacro`, `def-`, `defdyn` expand to `def` with metadata.
- Iteration: `each`, `for`, `loop`, `seq` expand to `while` loops.
- Threading: `->`, `->>`, `as->` rewrite nested calls.

Reading their source with `(doc defer)` and `macex` is a good way to learn idioms.

## Testing macros

A test file that uses a macro expands it when the file is compiled, so a broken macro stops the whole file from loading.
To isolate each case, expand at run time: `(eval '(my-macro …))` or `(macex1 '(my-macro …))` inside the test body.

## When not to

Prefer a function whenever the arguments can be evaluated normally.
Functions compose (you can pass them to `map`), macros do not; macros also make stack traces and error messages harder to read.
