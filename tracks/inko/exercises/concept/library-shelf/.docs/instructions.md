# Instructions

The village library is a single shelf in the back of the post office, run by Mr. Okafor. He keeps the titles of
the books on the shelf in order from left to right, and wants a little program to keep track of them.

## 1. Set up the shelf

Every new shelf starts with the three books the village was given when the library opened. Define the
`starter_shelf` method, which returns them in this order:

```inko
starter_shelf
# => ['Dune', 'Emma', 'Persuasion']
```

## 2. Look up a book

Define the `book_at` method, which takes the shelf and a position (counting from zero at the left) and returns the
title at that position, or `'empty'` when there's no book there:

```inko
book_at(['Dune', 'Emma'], position: 1)
# => 'Emma'
book_at(['Dune', 'Emma'], position: 4)
# => 'empty'
```

## 3. Shelve a returned book

Returned books go at the right end of the shelf. Define the `shelve` method, which takes the shelf and a title and
adds the book:

```inko
let shelf = ['Dune']

shelve(shelf, 'Emma')
shelf
# => ['Dune', 'Emma']
```

## 4. Lend the last book

Borrowers always take the rightmost book. Define the `lend_last` method, which removes the last book from the shelf
and returns its title, or returns `'nothing'` when the shelf is empty:

```inko
let shelf = ['Dune', 'Emma']

lend_last(shelf)
# => 'Emma'
shelf
# => ['Dune']
```

## 5. Check for a book

Define the `on_shelf?` method, which returns whether a title is on the shelf:

```inko
on_shelf?(['Dune', 'Emma'], 'Emma')
# => true
```

## 6. Tidy the shelf

Once a month, Mr. Okafor puts the books in alphabetical order. Define the `tidy` method, which sorts the shelf in
place:

```inko
let shelf = ['Persuasion', 'Dune', 'Emma']

tidy(shelf)
shelf
# => ['Dune', 'Emma', 'Persuasion']
```
