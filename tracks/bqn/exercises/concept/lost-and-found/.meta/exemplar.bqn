# claimed Unclaimed items → the items whose claimed flag is 0, in order
Unclaimed ⇐ {(¬𝕨) / 𝕩}

# limit Overdue days → the positions, counting from 0, of the items held longer than limit days
Overdue ⇐ {/ 𝕩 > 𝕨}

# counts Expand kinds → each kind repeated as many times as its count
Expand ⇐ {𝕨 / 𝕩}

# TicketDigits ticket → the digits of the ticket text, in order
TicketDigits ⇐ {(('0' ≤ 𝕩) ∧ 𝕩 ≤ '9') / 𝕩}

# ShelfNumbers counts → the shelf number of every item, when shelf i holds counts[i] items
ShelfNumbers ⇐ {/ 𝕩}
