# Instructions

Arjun is building a pocket calculator that, unlike his old one, remembers the whole calculation instead of only
the running result. As you type, it builds an expression:

```koka
// 2 * (3 + 4), negated
Neg(Mul(Num(2), Add(Num(3), Num(4))))
```

The `expr` type is already defined in `pocket-calculator.kk`. Help Arjun make the calculator understand it.

## 1. Work out the answer

Define `evaluate`: it takes an expression and returns its value.

```koka
evaluate(Mul(Num(2), Add(Num(3), Num(4))))
// => 14
```

## 2. Count the keys

Define `count-numbers`: it takes an expression and returns how many numbers were typed in to make it.

```koka
count-numbers(Add(Num(1), Mul(Num(2), Num(3))))
// => 3
```

## 3. Show the tape

The calculator prints the calculation on a paper tape. Define `display`: it takes an expression and returns it as
text — a number as its digits, a sum or a product in parentheses with `" + "` or `" * "` between the two sides,
and a negation as `-` before its expression.

```koka
display(Add(Num(1), Mul(Num(2), Num(3))))
// => "(1 + (2 * 3))"
display(Neg(Num(4)))
// => "-4"
```

## 4. Measure the nesting

The tape gets hard to read when expressions nest deeply. Define `depth`: it takes an expression and returns how
many levels deep it goes — 1 for a single number, and one more than the deepest part for anything else.

```koka
depth(Add(Num(1), Mul(Num(2), Num(3))))
// => 3
```

## 5. Drop the zeros

Arjun's young cousin keeps adding zero. Define `drop-zeros`: it takes an expression and returns it with every
addition of `Num(0)` removed, on either side and at any depth. When removing one makes another addition of zero,
that goes too.

```koka
drop-zeros(Mul(Add(Num(0), Num(5)), Num(2)))
// => Mul(Num(5), Num(2))
drop-zeros(Add(Num(7), Add(Num(0), Num(0))))
// => Num(7)
```
