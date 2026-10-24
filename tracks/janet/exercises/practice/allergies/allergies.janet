# An allergen is a keyword: :eggs :peanuts :shellfish :strawberries :tomatoes :chocolate
# :pollen :cats

(defn allergic-to?
  "(allergic-to? allergen score) -> true when the allergy score includes allergen"
  [allergen score]
  (error "implement me"))

(defn list
  "(list score) -> the allergens the allergy score includes, in the order listed above"
  [score]
  (error "implement me"))
