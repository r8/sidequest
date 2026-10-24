// ticket-number(text) -> the slot number written on a ticket, if it is one
pub fun ticket-number(text : string) : maybe<int>
  match text.parse-int
    Just(n) | n >= 0 -> Just(n)
    _ -> Nothing

// first-item(shelf) -> the first item on `shelf`, or "empty shelf"
pub fun first-item(shelf : list<string>) : string
  shelf.head.default("empty shelf")

// owner-label(owner) -> the tag's label for an item whose owner may be known
pub fun owner-label(owner : maybe<string>) : string
  match owner
    Just(name) -> "Owner: " ++ name
    Nothing -> "Owner unknown"

// claim(shelf, text) -> the item in the slot the ticket `text` names, if there is one
pub fun claim(shelf : list<string>, text : string) : maybe<string>
  match ticket-number(text)
    Just(n) -> shelf[n]
    Nothing -> Nothing
