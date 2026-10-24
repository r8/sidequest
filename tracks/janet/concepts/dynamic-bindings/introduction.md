# Introduction

A _dynamic binding_ is a setting named by a keyword that belongs to the running fiber and is visible to every function it calls, however deep.

- `(dyn key)` reads it (`nil` when unset); `(dyn key default)` falls back to `default`.
- `(setdyn key value)` sets it for the rest of the current fiber.
- `(with-dyns [key value …] body…)` sets it only while `body` runs, then the old values are back.

```janet
(defn loudness [] (dyn :volume 5))

(loudness)                          # => 5
(with-dyns [:volume 2] (loudness))  # => 2
```

Core functions use them: `print` and friends write to `(dyn :out)` when it is set, so binding `:out` to a buffer captures output:

```janet
(def out @"")
(with-dyns [:out out] (print "hi"))
out # => @"hi\n"
```
