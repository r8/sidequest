# Instructions

The village library has run on paper index cards for forty years, and the cards are falling apart. You offer to
move them into BQN. Each card records the member's name, their card number and the titles they have borrowed,
and you decide a namespace is the natural shape for one.

## 1. Issue a new card

Write the function `NewCard`. It takes a name‿number pair and returns a namespace with three fields: `name`,
`number`, and `books`, an empty list for a new member.

```bqn
card ← NewCard "Ada"‿1042
card.name
# ⇒ "Ada"
card.books
# ⇒ ⟨⟩
```

## 2. Greet the member

Write the function `Greeting`. It takes a card and returns the greeting the front desk prints for its holder.

```bqn
Greeting NewCard "Ada"‿1042
# ⇒ "Welcome back, Ada!"
```

## 3. Lend a book

Write the function `Borrow`. Its left argument is a card and its right argument a title; it returns a new card
with the same name and number, and the title added to the end of its books. The old card stays as it was.

```bqn
card2 ← (NewCard "Ada"‿1042) Borrow "Dune"
card2.books
# ⇒ ⟨"Dune"⟩
```

## 4. Count the loans

Write the function `LoanCount`. It takes a card and returns the number of books borrowed on it.

```bqn
LoanCount card2
# ⇒ 1
```

## 5. Enforce the limit

A member may have at most 5 books at a time. Write the function `CanBorrow`. It takes a card and returns `1` if
its holder may borrow another book, else `0`.

```bqn
CanBorrow card2
# ⇒ 1
```
