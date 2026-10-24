# Instructions

Mrs Okonkwo, a court stenographer, keeps her notes in a shorthand she has refined over thirty years, and she would like her notes to run as Forth.
She needs words that read the note that follows them, and a way to define her abbreviations.

## 1. Count the letters

Define `letters ( "word" -- n )`, which reads the next word of the input and leaves its length.

```forth
letters objection   \ leaves 9
```

## 2. Read up to the full stop

Define `sentence ( "text<.>" -- c-addr u )`, which reads the input up to the next full stop and leaves that text, without the full stop.

```forth
sentence The witness paused. \ leaves "The witness paused"
```

## 3. Peek at the next word

Define `peek ( "word" -- c-addr u )`, which leaves the next word of the input without consuming it: the interpreter still reads and runs that word afterwards.

```forth
peek 42   \ leaves "42", and then 42 itself
```

## 4. Replay a note

Define `replay ( i*x c-addr u n -- j*x )`, which interprets the Forth source in the string `n` times, each time on the stack the last one left.

```forth
0 s" 3 +" 4 replay   \ leaves 12
```

## 5. Define an abbreviation

Define `shorthand ( "abbr" "expansion" -- )`, which reads a name and then the rest of the line, and defines `abbr` as a word that interprets that text whenever it runs.
The abbreviation must keep its own copy of the text.

```forth
shorthand dbl 2 *
21 dbl   \ leaves 42
```
