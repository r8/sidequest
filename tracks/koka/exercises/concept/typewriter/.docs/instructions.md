# Instructions

Your aunt has found her grandfather's typewriter in the attic, and it still works — mostly. A few of the keys
misbehave, and she types her letters on it anyway. You are writing the program that tidies up what she types
once she has scanned it.

## 1. Spot the vowels

The vowel keys stick, and she wants to know where to check the letters. Define the `is-vowel` function: it takes
a character and returns whether it is one of the vowels `a`, `e`, `i`, `o`, `u`, in lower or upper case.

```koka
is-vowel('E')
// => True
```

## 2. Make a capital

Define the `capital` function: it takes a character and returns its upper-case form if it is a lower-case
letter from `a` to `z`, and the character unchanged otherwise.

```koka
capital('q')
// => 'Q'
```

## 3. Count the digits

The number keys are worn, so every digit needs checking. Define the `count-digits` function: it takes a text
and returns how many of its characters are digits.

```koka
count-digits("Flat 3b, 221 Baker Street")
// => 4
```

## 4. Find the letter that was meant

The letter keys type the letter one before the one pressed: pressing `b` types `a`, and pressing `a` types `z`,
going round the end of the alphabet. Define the `intended` function: it takes a character as typed and returns
the one that was pressed. Upper-case letters wrap around within `A` to `Z`, and anything that is not a letter
is unchanged.

```koka
intended('z')
// => 'a'
```

## 5. Repair a text

Define the `repair` function: it takes a whole text as typed and returns it with every character replaced by
the one that was meant.

```koka
repair("Gdkkn, vnqkc!")
// => "Hello, world!"
```
