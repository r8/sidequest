# Instructions

The Lantern Street Library is hosting a conference for volunteer archivists, and you have offered to print the name badges.
The registration form gives you each guest's full name — a first name, a space, and a surname — and the department they work in.
The badge printer is old and fussy, so every line has to be exactly right.

## 1. Print the main line

The main line of a badge is the guest's full name followed by their department in capitals, in parentheses.
Define the function `badge` that takes the full name and the department and returns that line.

```janet
(badge "Ada Lovelace" "engineering")
# => "Ada Lovelace (ENGINEERING)"
```

## 2. Print the initials

The corner of each badge shows the guest's initials: the first letter of the first name and the first letter of the surname, each followed by a full stop.
Define the function `initials` that takes the full name and returns the initials.

```janet
(initials "Grace Hopper")
# => "G.H."
```

## 3. Find the surname

The seating plan is sorted by surname.
Define the function `surname` that takes the full name and returns everything after the first space.

```janet
(surname "Katherine Johnson")
# => "Johnson"
```

## 4. Print the name tag

The lanyard has room for a tag exactly 24 characters wide: a `|`, a space, the name in a field of 20 characters, a space and a `|`.
A name shorter than 20 characters is padded with spaces on the right; a longer one is cut off after its first 20 characters.
Define the function `name-tag` that takes the full name and returns the tag.

```janet
(name-tag "Ada Lovelace")
# => "| Ada Lovelace         |"
```

## 5. Spot the doctors

Guests whose name starts with `"Dr. "` get a ribbon.
Define the function `doctor?` that takes the full name and returns `true` if it starts with `"Dr. "`, and `false` otherwise.

```janet
(doctor? "Dr. Mae Jemison")
# => true
```
