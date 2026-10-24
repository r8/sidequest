# Help

To get help with Koka:

- read [the Koka book](https://koka-lang.github.io/koka/doc/book.html) and the [standard library documentation](https://koka-lang.github.io/koka/doc/toc.html);
- the stub's `exn` in a function's type is there because it throws `implement me`; remove it once your solution is total;
- if the compiler reports that the effects do not match and names `div`, your function recurses in a way Koka cannot prove
  terminates (anything but recursion on a sub-term, such as `xs.drop(n)` or a `while`): add it to the type, as in
  `: <div,exn> int`, or recurse structurally on a pattern like `Cons(x, rest)`;
- compare your solution with the example using `npx quest compare koka/<slug>` once it passes.
