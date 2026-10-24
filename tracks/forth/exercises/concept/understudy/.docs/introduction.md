# Introduction

A colon definition is fixed when it is compiled: `: greet hello ;` calls the `hello` that existed at that moment, forever.
Sometimes a program needs a word whose behaviour can change later, or a word that is used before it can be written.
Forth's answer is the _deferred word_: a named slot holding an execution token, which it executes whenever it is called.

## `defer` and `is`

`defer name` creates a deferred word.
`xt is name` sets what it does:

```forth
defer greeting ( -- )
: hello ( -- ) ." Hello" ;
: hi ( -- ) ." Hi" ;

' hello is greeting
greeting          \ prints Hello
' hi is greeting
greeting          \ prints Hi
```

Words compiled with `greeting` in them call the deferred word, so they follow every change:

```forth
: welcome ( -- ) greeting ." , traveller" ;
welcome           \ prints Hi, traveller
```

A deferred word has the stack effect of whatever it holds; write that effect in a comment after `defer name`, and make every word you put into it match.
Calling a deferred word before anything was put into it throws an error ("deferred word is uninitialized").

`is` can be used inside a definition too.
It then reads the name of the deferred word when the definition is compiled, and takes the xt from the stack when it runs:

```forth
: be-polite ( -- ) ['] hello is greeting ;
: be-brief ( xt -- ) is greeting ;
```

## Reading what a deferred word holds

`action-of name ( -- xt )` gives back the xt a deferred word currently executes, so it can be compared, stored or put back later.
Like `is`, it reads the name at compile time inside a definition:

```forth
action-of greeting ' hi = .   \ prints -1
```

Saving the old action and restoring it afterwards is the usual way to change a deferred word for a while:

```forth
: briefly ( -- )
  action-of greeting  ['] hi is greeting
  welcome
  is greeting ;
```

`defer! ( xt xt-deferred -- )` and `defer@ ( xt-deferred -- xt )` do the same as `is` and `action-of` with the deferred word's own xt on the stack instead of its name in the source: `' hi ' greeting defer!`.
They are what you need when the deferred word is itself chosen at run time.

## Forward references

A word can only use words defined before it.
Two words that call each other — _mutual recursion_ — would need each to come first.
A deferred word breaks the cycle: declare the second word as deferred, write the first using it, then write the second and put it into the slot.

```forth
defer countdown ( n -- )
: tick ( n -- ) dup . 1- countdown ;
: (countdown) ( n -- ) dup 0> if tick else drop then ;
' (countdown) is countdown

3 countdown   \ prints 3 2 1
```

The parenthesised name is a common convention for "the implementation behind the deferred word".

## Pitfalls

- **Stack-effect drift.** Nothing checks that the words put into a deferred word share a stack effect; a mismatch shows up only when it runs.
- **Forgetting to restore.** A word that changes a deferred word for a moment must put the old action back, and it must not lose the saved xt among its other stack items.
- **`is` reads a name.** `is greeting` names the deferred word in the source; a deferred word chosen at run time needs `defer!`.
