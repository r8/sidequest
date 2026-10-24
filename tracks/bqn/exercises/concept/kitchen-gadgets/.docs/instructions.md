# Instructions

Grandpa Teo has bought a kitchen robot. It has one motor and a drawer full of attachments: a grater, a whisk, a
peeler, a measuring scoop. Each attachment is a function, and the robot's controls combine them. Teo can't make
sense of the manual, so you write the controls for him in BQN.

## 1. Run an attachment twice

Write the 1-modifier `_twice`. Its operand is an attachment (a function); the result applies the attachment to
the argument, then again to the result.

```bqn
-⟜3 _twice 10
# ⇒ 4
```

## 2. Run one attachment, then another

Write the 2-modifier `_then_`. Its operands are two attachments; the result applies the left one to the
argument, then the right one to the result.

```bqn
2⊸× _then_ (1⊸+) 5
# ⇒ 11
```

## 3. Scale a recipe

Write the 1-modifier `_times`. Its operand is a number; the result multiplies every amount in its argument
by that number.

```bqn
3 _times 100‿20‿2
# ⇒ 300‿60‿6
```

## 4. Try every attachment

Write the function `ApplyAll`. Its left argument is a list of attachments and its right argument a number;
it returns the result of applying each attachment to the number.

```bqn
⟨1⊸+, 2⊸×, -⟩ ApplyAll 5
# ⇒ 6‿10‿¯5
```

## 5. Set the measuring scoop

Write the function `Scoop`. It takes a number of grams and returns a function: one that adds that many grams to
the weight already in the bowl.

```bqn
add50 ← Scoop 50
Add50 120
# ⇒ 170
```
