# Hints

## General

- The [macros](https://janet-lang.org/docs/macros.html) page of the Janet documentation covers `defmacro`, quasiquote and hygiene.
- [`macex1`](https://janet-lang.org/api/index.html#macex1) shows what a macro expands to.

## 1. Say it twice

- Build a `do` form with quasiquote, and unquote the form twice.

## 2. Only when positive

- Take the body with `&` and splice it with `,;`.
- An `if` without an else branch returns `nil`.

## 3. Show your working

- A bracketed quasiquoted tuple, `~[…]`, is a tuple when it runs.
- `',form` puts the form in the expansion quoted, so at run time it is the code rather than its value.

## 4. Define a shorthand

- The expansion is a `def`.

## 5. Square it once

- Evaluate the expression into a local `def` and multiply that.
- Name the local with `gensym`, so it cannot clash with the caller's names.
