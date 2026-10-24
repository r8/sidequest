# About

[Koka](https://koka-lang.github.io) is a strongly typed functional language whose types track not only values but
the _effects_ a function may perform — exceptions, divergence, console output, state, or effects you define
yourself. Effect handlers let you give those effects meaning, which makes exceptions, generators, async code and
backtracking ordinary library features.

Koka compiles to C. Its Perceus reference counting frees memory precisely and reuses it in place, so purely
functional code can run as fast as imperative code.
