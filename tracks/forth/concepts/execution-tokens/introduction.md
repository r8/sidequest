# Introduction

An _execution token_ (xt) is a cell that stands for a word.
`'` reads the next word and pushes its xt, `[']` does the same inside a definition, and `execute` runs the word an xt stands for:

```forth
' 1+  3 swap execute   \ leaves 4
: next-of ( -- xt ) ['] 1+ ;
```

`:noname … ;` defines a word without a name and leaves its xt.
Because an xt is just a cell, it can be passed to other words, stored in variables and arrays, and compared with `=`:

```forth
: apply-to-pair ( a b xt -- a' b' )
  tuck execute -rot execute swap ;
create operations  ' + ,  ' - ,
```

Words that take an xt are Forth's higher-order functions; arrays of xts are jump tables.
