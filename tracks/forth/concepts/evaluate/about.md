# About

## What `evaluate` does

`evaluate` saves the current input source specification, makes the string the input source with `>in` at 0, runs the text interpreter over it, and restores the previous source when it is done or when an exception passes through.
`source-id` is -1 while a string is being evaluated.

Whatever state the interpreter is in carries over: evaluated while compiling, the text is compiled into the current definition; a definition started in the string and not finished stays open after it.
If the text throws in the middle of a definition, the interpreter is left compiling; code that evaluates untrusted text should catch, return to interpreting with `[`, and rethrow.

## Uses

- **Abbreviations and macros at the text level**, as `shorthand` in the lesson: store source, evaluate it later.
- **Generated code**: assemble a definition's text in a buffer and evaluate it, when a defining word with `does>` cannot express it.
- **Configuration and data files** written as Forth: `included` and `evaluate` let a program read its data with the interpreter.
- **Tests** of parsing and defining words, as this track's lessons do.

## Cautions

- Evaluated text is looked up in the search order at the time it runs, not where it was written; a word redefined in between changes its meaning.
- Strings to evaluate must stay valid while they run.
- `evaluate` is the most general tool Forth has and the slowest: prefer execution tokens, deferred words or defining words when they do the job.

## The outer interpreter

The loop that reads a word, looks it up, and executes, compiles or converts it to a number is the _outer interpreter_; `evaluate`, `included` and the interactive prompt all run it on different sources.
gforth lets programs extend it further, for example with recognizers that teach it new kinds of literals (in later versions than 0.7.3).
