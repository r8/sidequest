# Instructions

At the small border post on the mountain pass, officer Dimitra checks the parcels travellers declare. Every check
can fail, and when it does, the traveller is told exactly why. Help her turn the checks into code: each one
returns a `Result` whose error is a message for the traveller.

## 1. Check a weight

Parcels must weigh at least 1 kilogram (anything less isn't worth declaring) and at most 30. Define the
`check_weight` method, which returns the weight unchanged when it's allowed, the error `'too light'` below 1 and
`'too heavy'` above 30:

```inko
check_weight(12)
# => Result.Ok(12)
check_weight(45)
# => Result.Error('too heavy')
```

## 2. Read a number

Forms are filled in by hand. Define the `read_number` method, which turns the text into a number, with the error
`'not a number: TEXT'` when it isn't one:

```inko
read_number('12')
# => Result.Ok(12)
read_number('twelve')
# => Result.Error('not a number: twelve')
```

## 3. Read a weight

Define the `read_weight` method, which reads the number from the text and then checks it as a weight:

```inko
read_weight('45')
# => Result.Error('too heavy')
```

## 4. Add the duty

Imports pay a duty of 20% of their value, so the total due is the value plus a fifth of it (rounded down). Define the
`with_duty` method, which takes the result of reading a value and returns the result with the duty added:

```inko
with_duty(Result.Ok(150))
# => Result.Ok(180)
```

An error is passed on unchanged.

## 5. Name the form

When several forms are checked, Dimitra needs to know which one failed. Define the `on_form` method, which takes a
result and a form name, and puts `'FORM: '` in front of the error message:

```inko
on_form(Result.Error('too heavy'), 'C2')
# => Result.Error('C2: too heavy')
```

## 6. Stamp the parcel

Define the `stamp` method, which returns `'cleared: N'` for a successful check and `'held: REASON'` for a failed
one:

```inko
stamp(Result.Ok(180))
# => 'cleared: 180'
stamp(Result.Error('too heavy'))
# => 'held: too heavy'
```
