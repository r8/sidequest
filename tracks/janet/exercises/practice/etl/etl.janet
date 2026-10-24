# The legacy format maps each score to its uppercase letters: {1 ["A" "E"] 2 ["D" "G"]}.
# The new format maps each lowercase letter to its score: {"a" 1 "d" 2 "e" 1 "g" 2}.

(defn transform
  "(transform legacy) -> a struct mapping each lowercase letter to its score"
  [legacy]
  (error "implement me"))
