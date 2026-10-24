(defn flatten
  "(flatten items) -> a flat array of the values nested in items, leaving out nils"
  [items]
  (mapcat |(cond
             (indexed? $) (flatten $)
             (nil? $) []
             [$])
          items))
