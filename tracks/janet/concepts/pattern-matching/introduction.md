# Introduction

`(match value pattern result …)` tries each pattern in turn and evaluates the result of the first one that fits; if none does, it returns `nil`.

- A literal (number, string, keyword, `true`, `false`, `nil`) matches an equal value.
- A symbol matches anything and binds it; `_` matches anything and binds nothing.
- `[a b & rest]` matches an array or tuple element by element; extra elements are ignored.
- `{:key pattern}` matches a struct or table that has the key with a matching, non-nil value; extra keys are ignored.
- `(pattern condition …)` matches when the pattern does and every condition is truthy.
- `(@ name)` matches a value equal to the existing binding `name`.

```janet
(defn area [shape]
  (match shape
    [:square s] (* s s)
    ([:rect w h] (pos? w)) (* w h)
    _ 0))
```

The first match wins, so put specific patterns before general ones and a `_` case last.
