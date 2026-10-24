# Instructions

The members of the Shorthand Club write faster than anyone in town, because they never write anything out in full.
The club has decided to bring its philosophy to programming: every member contributes a macro that saves keystrokes, and the best ones go into the club's library.
You are the newest member, and you have five macros to write.

## 1. Say it twice

Define the macro `twice` that takes one form and runs it two times, returning the value of the second run.

```janet
(macex1 '(twice (print "hip hip")))
# => (do (print "hip hip") (print "hip hip"))
```

## 2. Only when positive

Define the macro `when-positive` that takes a number expression and a body, and runs the body only when the number is greater than zero.
It returns the value of the body's last form, or `nil` when the number is not positive (and the body does not run at all).

```janet
(when-positive 3 (print "three is positive") :yes)
# => :yes
```

## 3. Show your working

Define the macro `show` that takes a form and returns a tuple of the form itself, as code, and the form's value.

```janet
(show (+ 1 2))
# => [(+ 1 2) 3]
```

## 4. Define a shorthand

Define the macro `defshort` that takes a short name and an expression, and defines the short name as the expression's value.

```janet
(defshort str string)
(str "short" "hand")
# => "shorthand"
```

## 5. Square it once

Define the macro `square` that takes an expression and returns its square.
The expression must be evaluated exactly once, and the macro must work whatever names the caller uses.

```janet
(square (+ 1 2))
# => 9
```
