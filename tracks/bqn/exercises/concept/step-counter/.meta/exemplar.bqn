# stride Distance steps → the metres walked each day
Distance ⇐ {𝕨 × 𝕩}

# goal GoalMet steps → 1 for each day with at least goal steps, else 0
GoalMet ⇐ {𝕩 ≥ 𝕨}

# DaysRecorded steps → the number of days recorded
DaysRecorded ⇐ {≠ 𝕩}

# steps AddDay today → the step counts with today's at the end
AddDay ⇐ {𝕨 ∾ 𝕩}

# lastWeek Change thisWeek → how many more steps each day this week
Change ⇐ {𝕩 - 𝕨}

# DayNumbers steps → the day numbers 1, 2, … of the recorded days
DayNumbers ⇐ {1 + ↕ ≠ 𝕩}
