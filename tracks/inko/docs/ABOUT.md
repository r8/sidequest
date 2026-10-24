# About

[Inko](https://inko-lang.org) is a statically typed language for building concurrent software that is
reliable by construction. Concurrency uses lightweight processes (actors) that share nothing and talk through
messages; memory is managed by single ownership with move semantics, so there is no garbage collector and no
data race can compile.

Inko compiles to native code through LLVM and has a standard library covering I/O, networking, and testing.
