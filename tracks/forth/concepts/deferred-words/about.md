# About

## The words

| Word | Stack effect | Notes |
| --- | --- | --- |
| `defer name` | `( "name" -- )` | creates the deferred word; calling it before it is set throws |
| `is name` | `( xt "name" -- )` | sets it; inside a definition the name is read at compile time |
| `action-of name` | `( "name" -- xt )` | what it holds; same parsing rule |
| `defer!` | `( xt xt-deferred -- )` | `is` with the deferred word's xt on the stack |
| `defer@` | `( xt-deferred -- xt )` | `action-of` likewise |

All five are in the Forth 2012 standard.

## Uses

- **Forward references.** Mutual recursion, or a high-level word written before the low-level words it calls.
  `defer foo … : (foo) … ; ' (foo) is foo` is the usual shape.
- **Hooks and plug-ins.** gforth itself is full of them: `type`, `emit` and the text interpreter's error handling are deferred, so a program can redirect output or change how errors are reported.
- **Strategy selection.** One deferred `compare-items` used by a sort, set to the order wanted before sorting.
- **Temporary changes.** Save with `action-of`, set with `is`, run, restore. When the code in the middle can throw, put the restore after a `catch` so it happens either way:

  ```forth
  : with-greeting ( xt-greeting xt-body -- )
    action-of greeting >r  swap is greeting
    catch  r> is greeting  throw ;
  ```

## Deferred words and execution tokens

A deferred word is like a variable holding an xt plus `@ execute` on every call, with the difference that it is called by name like any word.
`' greeting` gives the xt of the deferred word itself (what `defer!` and `defer@` take), not of its current action.

## Costs

A deferred call is one extra indirection.
A deferred word that is never meant to change after start-up is still the cleanest way to break a cycle between definitions.
