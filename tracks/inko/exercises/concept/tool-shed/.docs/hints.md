# Hints

## General

- The manual's [memory management][memory] page explains `ref`, `mut` and how borrows are checked.
- The shed owns its tools: an `Array[Tool]` field.

## 1. Stock the shed

- `store` takes ownership of the tool and moves it into the array.

## 2. Find a tool

- `iter` lends each tool; iterators have a `find` method that returns the first match as an option.

## 3. Use a tool in the shed

- `work` changes the tool, so you need mutable borrows: `iter_mut`, inside an `fn mut` method.

## 4. Sharpen everything

- Loop over mutable borrows of the tools again.

## 5. Lend a tool

- First find the index of the tool (`with_index` helps), then take it out of the array with `remove_at`, which
  returns the owned tool. `ok` turns its `Result` into an `Option`.

[memory]: https://docs.inko-lang.org/manual/latest/getting-started/memory-management/
