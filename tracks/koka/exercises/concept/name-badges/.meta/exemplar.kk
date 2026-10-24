// badge(name, company) -> the badge text for `name` from `company`
pub fun badge(name : string, company : string) : string
  name ++ ", " ++ company.to-upper

// display-name(name) -> the name to print for a registration that gave `name`
pub fun display-name(name : string) : string
  val trimmed = name.trim
  if trimmed.is-empty then "Guest" else trimmed

// table-label(table, seat) -> the label for seat `seat` at table `table`
pub fun table-label(table : int, seat : int) : string
  "T" ++ table.show.pad-left(2, '0') ++ "-" ++ seat.show

// framed(text) -> `text` in a frame of stars, on three lines
pub fun framed(text : string) : string
  val border = "*".repeat(text.count + 4)
  border ++ "\n* " ++ text ++ " *\n" ++ border

// is-staff(email) -> whether `email` is an organiser's address
pub fun is-staff(email : string) : bool
  email.ends-with("@kokaconf.org").is-just
