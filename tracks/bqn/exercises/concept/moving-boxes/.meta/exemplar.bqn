# An item is a number; a box is a list of items and boxes.

# Layers thing → how many boxes deep its most deeply packed item is (0 for a lone item)
Layers ⇐ {≡ 𝕩}

# Unpack boxes → one box holding the contents of every box, in order
Unpack ⇐ {∾ 𝕩}

# box AddItem thing → the box with thing added at the end as a single element
AddItem ⇐ {𝕨 ∾ <𝕩}

# label Label box → the two-element list of label and box
Label ⇐ {𝕨 ⋈ 𝕩}

# Shelve boxes → a table with one row per box; every box holds the same number of items
Shelve ⇐ {> 𝕩}

# boxes Matches box → 1 for each box of boxes with exactly the same contents as box, else 0
Matches ⇐ {𝕨 ≡¨ <𝕩}
