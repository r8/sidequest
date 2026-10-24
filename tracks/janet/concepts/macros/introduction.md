# Introduction

A _macro_ is a function the compiler calls at compile time.
It receives its arguments as unevaluated code and returns a form, which is compiled in place of the macro call.

```janet
(defmacro my-unless [condition & body]
  ~(if ,condition nil (do ,;body)))

(macex1 '(my-unless ready? (launch)))
# => (if ready? nil (do (launch)))
```

Macros let you control evaluation — skip, repeat or delay arguments — and add new syntax or definitions.
Two rules keep them correct:

- evaluate each argument once, by binding it to a local in the expansion;
- name such locals with `(gensym)` (or `with-syms`), so they cannot clash with the caller's names.

Symbols in an expansion are resolved where the macro is used; unquote a helper function, `~(,helper ,x)`, to embed it.
