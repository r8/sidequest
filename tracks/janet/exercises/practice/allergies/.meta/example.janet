# An allergen is a keyword: :eggs :peanuts :shellfish :strawberries :tomatoes :chocolate
# :pollen :cats

(def- allergens [:eggs :peanuts :shellfish :strawberries :tomatoes :chocolate :pollen :cats])

(defn allergic-to?
  "(allergic-to? allergen score) -> true when the allergy score includes allergen"
  [allergen score]
  (pos? (band score (blshift 1 (index-of allergen allergens)))))

(defn list
  "(list score) -> the allergens the allergy score includes, in the order listed above"
  [score]
  (filter |(allergic-to? $ score) allergens))
