// ticket-number(text) -> the slot number written on a ticket, if it is one
pub fun ticket-number(text : string) : exn maybe<int>
  throw("implement me", ExnTodo)

// first-item(shelf) -> the first item on `shelf`, or "empty shelf"
pub fun first-item(shelf : list<string>) : exn string
  throw("implement me", ExnTodo)

// owner-label(owner) -> the tag's label for an item whose owner may be known
pub fun owner-label(owner : maybe<string>) : exn string
  throw("implement me", ExnTodo)

// claim(shelf, text) -> the item in the slot the ticket `text` names, if there is one
pub fun claim(shelf : list<string>, text : string) : exn maybe<string>
  throw("implement me", ExnTodo)
