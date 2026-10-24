# Introduction

You have used words that read ahead in the source: `char a`, `' dup`, `create name`, `s" text"`.
They are _parsing words_, and they are ordinary Forth words built on a small interface to the text interpreter, which any program can use too.

## The input buffer

The text interpreter works through its _input source_ — a line typed at the prompt, a line of a file, or a string — one word at a time.
Two words show where it is:

- `source ( -- c-addr u )` is the whole current input buffer;
- `>in ( -- addr )` is a variable holding the offset of the next character the interpreter will read.

Interpreting a word means: skip spaces, read characters up to the next space, advance `>in` past them, then execute or compile the word.
When a word executes, `>in` points just after it (past the one space that ended it), so whatever it reads from the input is the text that follows it in the source.

## `parse-name` and `parse`

`parse-name ( "name" -- c-addr u )` skips leading spaces and returns the next space-delimited word, advancing `>in` past it.
At the end of the input it returns a string of length 0.

```forth
: greet ( "name" -- )
  ." Hello, " parse-name type ;

greet Ada   \ prints Hello, Ada
```

`parse ( char "text<char>" -- c-addr u )` returns the text up to the next occurrence of `char` (or the end of the input), without skipping anything first, and moves `>in` past the delimiter.

```forth
: say ( "text<;>" -- ) [char] ; parse type ;
say several words; 1 2 + .   \ prints several words3
```

The string is a piece of the input buffer itself, not a copy.
It stays valid only as long as that buffer does: for a line typed at the prompt, until the next line; for a string being evaluated, as long as that string exists.
Copy it somewhere — a buffer, or the dictionary with `here` and `allot` — to keep it.

Because `>in` is a variable, a word can save it, parse, and put it back, so that the interpreter reads the same text again.
Setting it to the length of `source` skips the rest of the line, which is how `\` works.

## When parsing happens

A parsing word reads the input _when it runs_.
Used in a definition, it runs when the definition runs, and reads whatever follows the place the definition is called from — not the text of the definition itself.
That is why `create` inside a defining word reads the new word's name from the line that uses the defining word.
(Immediate parsing words such as `[char]` and `[']` run, and read, while the definition is compiled.)

## `evaluate`

`evaluate ( i*x c-addr u -- j*x )` makes a string the input source and interprets it exactly as if it were a line of the program, then returns to the source it came from:

```forth
s" 2 3 +" evaluate .   \ prints 5
```

The string can define words, use parsing words (which then read from that string), and do anything else a line of source could.
Its stack effect is whatever the text does, which is why it is written `( i*x c-addr u -- j*x )`.
Since the string's address and length are consumed before it runs, the text works on the stack as it was below them.

`evaluate` is how a program builds code at run time — text assembled in a buffer, or stored earlier — and runs it with the full power of the interpreter.

## Pitfalls

- **Strings into the input buffer go stale.** Keep a copy of anything you parse if it must outlive the line.
- **A parsing word in a definition parses at run time.** Check which text it will read when it runs.
- **`parse` does not skip spaces; `parse-name` does.**
- **Evaluated text sees the stack below its own string.** Keep the string out of the way when the text should work on other items, for example on the return stack.
