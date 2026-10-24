# A card is a namespace with the fields name (a string), number and books (a list of titles).
limit ← 5

# NewCard name‿number → a card for a new member, with no books
NewCard ⇐ {𝕊 n‿id:
  name ⇐ n
  number ⇐ id
  books ⇐ ⟨⟩
}

# Greeting card → "Welcome back, <name>!"
Greeting ⇐ {"Welcome back, " ∾ 𝕩.name ∾ "!"}

# card Borrow title → a new card with title added to the end of its books
Borrow ⇐ {
  name ⇐ 𝕨.name
  number ⇐ 𝕨.number
  books ⇐ 𝕨.books ∾ ⟨𝕩⟩
}

# LoanCount card → the number of books borrowed on the card
LoanCount ⇐ {≠ 𝕩.books}

# CanBorrow card → 1 if the card holds fewer than 5 books, else 0
CanBorrow ⇐ {limit > LoanCount 𝕩}
