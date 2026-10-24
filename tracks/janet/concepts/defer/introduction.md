# Introduction

Janet has three macros for code that must run after other code, even when that code raises an error.

- `(defer cleanup body…)` runs `body`, then always runs `cleanup`, and returns the body's value; an error from the body still propagates after the cleanup.
- `(edefer cleanup body…)` runs `cleanup` only when the body raises an error — "undo on failure".
- `(with [name resource &opt close-fn] body…)` binds `name` to `resource`, runs the body, then closes the resource: with `(close-fn name)` when given, otherwise by calling its `:close` method, `(:close name)`.

```janet
(with [f (file/open "notes.txt")]
  (file/read f :all))   # the file is closed afterwards, error or not

(defer (print "done")
  (print "working"))    # prints working, then done
```
