# Hints

## General

- The [namespaces documentation](https://mlochbaum.github.io/BQN/doc/namespace.html) covers `⇐`, field
  access and destructuring.
- The [blocks documentation](https://mlochbaum.github.io/BQN/doc/block.html) shows how a block with exports
  returns a namespace.

## 1. Issue a new card

- A header such as `𝕊 n‿id:` takes the pair apart.
- Each field is a line (or a `⋄`-separated statement) defined with `⇐`.

## 2. Greet the member

- Read the field with `𝕩.name` and join the pieces with `∾`.

## 3. Lend a book

- A namespace cannot be changed; build a new one with all three fields.
- Adding one string to a list of strings means joining a list holding that string.

## 4. Count the loans

- `≠` gives the length of a list.

## 5. Enforce the limit

- Comparison returns `1` or `0` already.
