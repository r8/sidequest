# About

## What `postpone` does

`postpone name` appends the _compilation semantics_ of `name` to the current definition:

- for an ordinary word, the code it appends compiles a call to `name` when it runs;
- for an immediate word, it appends a call to `name` itself, so `name` does its compile-time work when the enclosing (immediate) word runs.

`postpone` replaces two older words, `[compile]` (for immediate words) and `compile` (for ordinary ones), and does the right thing for both.

## Macros

```forth
: 2dup+ ( -- ) postpone 2dup postpone + ; immediate
```

A macro avoids a call at run time, which matters in tight loops on a simple threaded system; in gforth the gain is small, and the usual reason is syntax rather than speed.
Macros are harder to debug than ordinary words (`see` shows the expansion, not the macro), so use them when they make the code read better.

gforth also has `]] … [[`, which postpones every word between them: `: 2dup+ ]] 2dup + [[ ; immediate`.

## New control structures

Control words leave _control-flow stack_ entries (on the data stack in gforth) at compile time and consume them later.
A macro that postpones `if`, `?do`, `begin` or `while` leaves the same entries, so its user closes it with the matching word, or with a macro that postpones that word:

```forth
: times ( -- ) 0 postpone literal postpone ?do ; immediate
: end-times ( -- ) postpone loop ; immediate
```

For structures that do not map onto existing ones, the standard has `ahead`, `cs-pick` and `cs-roll` to rearrange the control-flow entries.

## Compiling values and tokens

- `postpone literal` (and `postpone 2literal`, `postpone fliteral`) compiles a value that is on the stack at compile time.
- `compile, ( xt -- )` compiles a call to an xt, typically one found with `'` or `find-name` while the macro runs.
- `postpone` itself reads its name when the macro is compiled; to postpone a word chosen at run time, use `find-name name>comp` in gforth, or the standard `find`.

## Pitfalls

- A macro that is not `immediate` runs its `postpone`d code at the wrong time, compiling into the definition that is current when it is called.
- Macros nest: a macro may use other macros, which are expanded when it is compiled, not when it runs.
- Words that parse (`'`, `[char]`, `s"`) inside a macro read from the source of the definition being compiled, which is often exactly what is wanted.
