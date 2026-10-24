# Changes are amounts put into (positive) or taken out of (negative) the jar, one per week.

# Balances changes → the balance at the end of each week, starting from an empty jar
Balances ⇐ {+` 𝕩}

# start BalancesFrom changes → the balance at the end of each week, starting from start
BalancesFrom ⇐ {𝕨 +` 𝕩}

# Records balances → the highest balance up to and including each week
Records ⇐ {⌈` 𝕩}

# NeverInDebt balances → 1 for each week up to the first negative balance, 0 from then on
NeverInDebt ⇐ {∧` 𝕩 ≥ 0}

# price GoalReached changes → 0 for each week before the jar first holds at least price, 1 from then on
GoalReached ⇐ {∨` 𝕨 ≤ Balances 𝕩}
