# Carton weights → the twelve weights as a carton of 2 rows of 6, first row first
Carton ⇐ {2‿6 ⥊ 𝕩}

# Dimensions tray → the shape of the tray
Dimensions ⇐ {≢ 𝕩}

# EggCount tray → the number of eggs in a tray of any shape
EggCount ⇐ {≠ ⥊ 𝕩}

# Unpack tray → the weights of a tray of any shape as one list, in packing order
Unpack ⇐ {⥊ 𝕩}

# Turn carton → the carton with its columns as rows
Turn ⇐ {⍉ 𝕩}

# cartons Crate weights → that many cartons of 2 rows of 6, as an array of shape cartons‿2‿6
Crate ⇐ {𝕨‿2‿6 ⥊ 𝕩}
