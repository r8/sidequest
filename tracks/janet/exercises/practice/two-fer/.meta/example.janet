(defn two-fer
  "(two-fer &opt name) -> string"
  [&opt name]
  (default name "you")
  (string "One for " name ", one for me."))
