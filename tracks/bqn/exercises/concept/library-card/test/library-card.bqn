t ← •Import "../lib/test.bqn"
g ← •Import "../library-card.bqn"

Ada ← {𝕊: g.NewCard "Ada"‿1042}
Bo ← {𝕊: g.NewCard "Bo"‿7}
# Lent titles → Ada's card after borrowing each of the titles in order
Lent ← {(Ada @) {𝕩 g.Borrow 𝕨}´ ⌽𝕩}

t.Run ⟨
  "1. a new card has the member's name"‿{𝕊: "Ada" t.Expect (Ada @).name}
  "1. a new card has its number"‿{𝕊: 1042 t.Expect (Ada @).number}
  "1. a new card has no books"‿{𝕊: ⟨⟩ t.Expect (Ada @).books}
  "1. each card is its own"‿{𝕊: c ← Bo @ ⋄ "Bo"‿7 t.Expect c.name‿c.number}
  "2. greeting Ada"‿{𝕊: "Welcome back, Ada!" t.Expect g.Greeting Ada @}
  "2. greeting Bo"‿{𝕊: "Welcome back, Bo!" t.Expect g.Greeting Bo @}
  "3. the first loan"‿{𝕊: ⟨"Dune"⟩ t.Expect ((Ada @) g.Borrow "Dune").books}
  "3. a second loan goes at the end"‿{𝕊: "Dune"‿"Emma" t.Expect (((Ada @) g.Borrow "Dune") g.Borrow "Emma").books}
  "3. the new card keeps the name and number"‿{𝕊: c ← (Ada @) g.Borrow "Dune" ⋄ "Ada"‿1042 t.Expect c.name‿c.number}
  "3. the old card is unchanged"‿{𝕊: c ← Ada @ ⋄ c g.Borrow "Dune" ⋄ ⟨⟩ t.Expect c.books}
  "4. no loans"‿{𝕊: 0 t.Expect g.LoanCount Ada @}
  "4. one loan"‿{𝕊: 1 t.Expect g.LoanCount Lent ⟨"Dune"⟩}
  "4. three loans"‿{𝕊: 3 t.Expect g.LoanCount Lent "Dune"‿"Emma"‿"Ulysses"}
  "5. a new member may borrow"‿{𝕊: 1 t.Expect g.CanBorrow Ada @}
  "5. four books still leaves room"‿{𝕊: 1 t.Expect g.CanBorrow Lent "A"‿"B"‿"C"‿"D"}
  "5. five books is the limit"‿{𝕊: 0 t.Expect g.CanBorrow Lent "A"‿"B"‿"C"‿"D"‿"E"}
⟩
