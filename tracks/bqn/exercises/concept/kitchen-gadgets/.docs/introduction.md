# Introduction

## Functions are values

In BQN a function is a value like any other. It can be named, put in a list, passed to another function and
returned from one. What decides how a value is _used_ is the spelling of the name, as you saw in the first
lesson: a capitalised name is used as a function, a lowercase name as a subject.

```bqn
Double ← 2⊸×
Double 4           # 8: called
double             # the same function, as a subject: it can be stored and passed around
⟨double, -, √⟩     # a list of three functions
```

Note that `double ← 2⊸×` is an error ("Role of the two sides in assignment must match"): the expression
`2⊸×` is a function, so the name it is given must be spelled as one. Define with a capital and refer to it in
lowercase.

A list can hold primitives directly too: `⟨+, -, ×⟩` is a list of three functions. `•Type` tells what kind of
value something is: `1` for a number, `2` for a character, `3` for a function, `4` and `5` for 1- and
2-modifiers.

## Calling a function you were given

Inside a block, `𝕩` and `𝕨` are the arguments as subjects. The same arguments spelled `𝕏` and `𝕎` are used as
functions:

```bqn
{𝕏 4}¨ ⟨2⊸×, -⟩     # ⟨8, ¯4⟩: each function is called on 4
```

## Returning a function

A block can return a function. The result of a call is always a subject, so give it a capitalised name to call
it:

```bqn
Adder ← {𝕩⊸+}       # returns a function that adds 𝕩
add ← Adder 5
Add 3               # 8
```

The returned function remembers the `𝕩` it was made with, even after `Adder` has finished.

## Your own modifiers

A modifier is like a function, but its inputs, the **operands**, are given when it is written next to a
function, not when it is called. You have used several: `¨`, `˜`, `∘`, `⊸`, `○`. You can write your own as a
block that mentions an operand:

- `𝔽` is the left operand used as a function, `𝕗` the same operand used as a subject;
- `𝔾` and `𝕘` are the right operand, which only 2-modifiers have.

A block that mentions `𝔽` or `𝕗` but not `𝔾` or `𝕘` is a 1-modifier, and its name must start with an
underscore. A block that mentions `𝔾` or `𝕘` is a 2-modifier, and its name starts **and ends** with an
underscore:

```bqn
_twice ← {𝔽 𝔽 𝕩}      # 1-modifier: the operand on its left
-⟜3 _twice 10         # 4

_after_ ← {𝔽 𝔾 𝕩}     # 2-modifier: operands on both sides
-⟜1 _after_ (2⊸×) 5   # 9
```

Because the block also uses `𝕩`, applying the modifier to its operands gives a function, which then waits for
its arguments, just like `-⟜3¨` does. If a call has a left argument, `𝕨` is available in the block as usual.

An operand doesn't have to be a function: `𝕗` uses it as a subject, so a number can be an operand:

```bqn
_plus ← {𝕗 + 𝕩}
10 _plus 5            # 15: 10 is the operand, 5 the argument
```

A modifier's header names the operands where they stand: `𝔽 _𝕣 𝕩:` for a 1-modifier, `𝔽 _𝕣_ 𝔾 𝕩:` for a
2-modifier, where `_𝕣` and `_𝕣_` stand for the modifier itself.

## Pitfalls

- Modifiers group from left to right, before functions are applied: `2⊸× _after_ 1⊸+ 5` means
  `((2⊸× _after_ 1)⊸+) 5`. Put a composed right operand in parentheses.
- The result of a call is a subject: `(Adder 3) 4` is "Double subjects". Name the result with a capital, or
  call it with `𝕏` in a block.
- Names that start with `_` can't hold subjects or functions, only modifiers, and the other way round.
