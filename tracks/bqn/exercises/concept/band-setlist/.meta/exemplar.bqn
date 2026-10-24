# A setlist is a list of song titles (strings).

# TitleLengths setlist → the number of characters in each title
TitleLengths ⇐ {≠¨ 𝕩}

# Announce setlist → "Next up: <title>!" for each title
Announce ⇐ {{"Next up: " ∾ 𝕩 ∾ "!"}¨ 𝕩}

# setlist Credit writers → "<title> by <writer>" for each title and its writer
Credit ⇐ {𝕨 {𝕨 ∾ " by " ∾ 𝕩}¨ 𝕩}

# ToMinutes timings → the timings (a list of lists of seconds) in minutes, in the same shape
ToMinutes ⇐ {𝕩 ÷ 60}

# TourTitleLengths tour → the title lengths of each setlist in the tour
TourTitleLengths ⇐ {≠¨¨ 𝕩}
