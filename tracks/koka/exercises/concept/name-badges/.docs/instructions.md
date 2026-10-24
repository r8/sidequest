# Instructions

KokaConf is next week, and Priya is in charge of the welcome desk. The badge printer takes plain text, so she
needs a few functions that turn the registration data into what gets printed.

## 1. Print a badge

A badge shows the person's name, a comma and a space, and the name of their company in capitals. Define the
`badge` function: it takes a name and a company and returns the badge text.

```koka
badge("Ana Lima", "Acme")
// => "Ana Lima, ACME"
```

## 2. Clean up the name

Some people type spaces around their names when they register, and some leave the name out entirely. Define the
`display-name` function: it takes the name as registered and returns it without the spaces at either end — or
`"Guest"` if nothing is left.

```koka
display-name("  Ana Lima ")
// => "Ana Lima"
display-name(" ")
// => "Guest"
```

## 3. Label the seats

For the conference dinner, every seat gets a label: a `T`, the table number with at least two digits, a dash, and
the seat number. Define the `table-label` function: it takes the table and the seat number and returns the label.

```koka
table-label(7, 3)
// => "T07-3"
```

## 4. Frame the speakers' names

Speakers get their names in a frame of stars: a line of stars, then the name with a star and a space on either
side, then the same line of stars again. Both lines of stars are as long as the middle line. Define the `framed`
function: it takes the text and returns the three lines, joined with new lines.

```koka
framed("Hi")
// => "******\n* Hi *\n******"
```

## 5. Recognise the organisers

Organisers have email addresses that end in `@kokaconf.org`. Define the `is-staff` function: it takes an email
address and returns whether it belongs to an organiser.

```koka
is-staff("mei@kokaconf.org")
// => True
```
