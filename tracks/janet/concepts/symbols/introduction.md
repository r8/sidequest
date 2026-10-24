# Introduction

A _symbol_ is a name as a value.
In code, a symbol is looked up: `x` evaluates to what `x` is bound to.
Quoted, it is the symbol itself:

```janet
'potion               # => potion
(type 'potion)        # => :symbol
(symbol "fire-ball")  # => fire-ball
(string 'fire-ball)   # => "fire-ball"
(= 'a (symbol "a"))   # => true
```

Symbols are like keywords without the colon — interned, compared by value — except that a keyword evaluates to itself and a symbol is looked up.
Data uses keywords; code is made of symbols.
