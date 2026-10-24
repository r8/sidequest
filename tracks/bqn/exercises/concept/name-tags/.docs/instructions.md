# Instructions

You are volunteering at the registration desk of a small conference. The badge printer is ancient and takes
its text from a BQN program, which someone has to write. That someone is you.

## 1. Greet the attendee

Write the function `Badge`. It takes an attendee's name and returns the text printed on the badge: `Hello, my
name is ` followed by the name.

```bqn
Badge "Grace"
# ⇒ "Hello, my name is Grace"
```

## 2. Put the full name together

Write the function `FullName`. Its left argument is the first name and its right argument the family name;
return them joined by a single space.

```bqn
"Ada" FullName "Lovelace"
# ⇒ "Ada Lovelace"
```

## 3. Print the speakers' names in capitals

Speakers' badges are printed in capital letters. Write the function `Shout`. It takes a name and returns it
with every small letter from `a` to `z` turned into its capital; every other character stays as it is.

```bqn
Shout "Ada Lovelace"
# ⇒ "ADA LOVELACE"
```

## 4. Assign the tables

Lunch tables are lettered `A`, `B`, `C`, … in order. Write the function `TableLetter`. It takes a table number,
counting from 0, and returns that table's letter. It must work on a list of table numbers too, returning a
string.

```bqn
TableLetter 2
# ⇒ 'C'
TableLetter 0‿1‿3
# ⇒ "ABD"
```

## 5. Print a nickname

Some attendees want their nickname on the badge, in double quotes. Write the function `Quote`. It takes a
string and returns it between two double-quote characters.

```bqn
Quote "Amazing Grace"
# ⇒ """Amazing Grace"""
```

The result has 15 characters: BQN writes each double quote inside a string as two.
