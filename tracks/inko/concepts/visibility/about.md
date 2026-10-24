# About

## What `pub` applies to

| Symbol | Private | Public |
| --- | --- | --- |
| constant | `let LIMIT = 10` | `let pub LIMIT = 10` |
| type | `type Plant {}` | `type pub Plant {}` |
| trait | `trait Grows {}` | `trait pub Grows {}` |
| field | `let @name: String` | `let pub @name: String` |
| method | `fn grow`, `fn mut grow` | `fn pub grow`, `fn pub mut grow` |
| process message | `fn async start` | `fn pub async start` |

`pub` comes right after the keyword (`fn pub`, `let pub`, `type pub`), and `mut` goes directly before the method
name (`fn pub mut`).

## Root namespaces

A private symbol is visible throughout its _root namespace_: `std.foo.bar` can use private symbols of
`std.baz`, because both start with `std`. Using a private symbol from another root namespace, by importing it,
calling a private method or reading a private field, is a compile-time error.

## Public types with private parts

A public type may have private fields and methods; outside its namespace it can then only be created and used
through its public methods, which keeps its invariants safe. A public method's signature must only mention types
that are public themselves, or callers couldn't use it.

## Processes

The fields and ordinary (non-`async`) methods of a process type are private to the process itself, whatever their
`pub`: other processes can only send it messages (`fn pub async` methods). That rule is what makes sharing a process
between processes safe.

## Trait implementations

Methods in an `impl Trait for Type` block are public when the trait's methods are, and must be declared with the
same visibility as the trait.
