# A card is a namespace with the fields name (a string), number and books (a list of titles).

# NewCard name‿number → a card for a new member, with no books
NewCard ⇐ {𝕊 𝕩: "implement me" ! 0}

# Greeting card → "Welcome back, <name>!"
Greeting ⇐ {𝕊 𝕩: "implement me" ! 0}

# card Borrow title → a new card with title added to the end of its books
Borrow ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# LoanCount card → the number of books borrowed on the card
LoanCount ⇐ {𝕊 𝕩: "implement me" ! 0}

# CanBorrow card → 1 if the card holds fewer than 5 books, else 0
CanBorrow ⇐ {𝕊 𝕩: "implement me" ! 0}
