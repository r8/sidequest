# Help

To get help with Forth:

- read the [Gforth manual](https://gforth.org/manual/) or [Starting Forth](https://www.forth.com/starting-forth/);
- run `gforth` for a REPL; `.s` shows the stack without changing it, and `see <word>` decompiles a word;
- write a stack-effect comment `( before -- after )` for every word, and check it before you test;
- compare your solution with the example using `npx quest compare forth/<slug>` once it passes.
