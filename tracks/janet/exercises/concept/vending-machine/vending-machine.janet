(defn dispense
  "(dispense machine code) -> string; the item's name, after taking one from the slot's stock"
  [machine code]
  (error "implement me"))

(defn try-dispense
  "(try-dispense machine code) -> string or nil; like dispense, nil instead of an error"
  [machine code]
  (error "implement me"))

(defn insert-coins
  "(insert-coins coins) -> number; the total, errors with \"unknown coin\" for a bad coin"
  [coins]
  (error "implement me"))

(defn restock-check
  "(restock-check machine code) -> string or :empty; like dispense, :empty when sold out"
  [machine code]
  (error "implement me"))

(defn attempt
  "(attempt f) -> tuple; [:ok result] or [:error error-value] from calling f"
  [f]
  (error "implement me"))
