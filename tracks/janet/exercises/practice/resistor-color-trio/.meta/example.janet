# A color is a keyword: :black :brown :red :orange :yellow :green :blue :violet :grey :white
# A label is a struct {:value 2 :unit :kiloohms}; the unit is one of :ohms :kiloohms
# :megaohms :gigaohms.
# `label` is a core Janet macro, so the function is called `resistance`.

(def- bands [:black :brown :red :orange :yellow :green :blue :violet :grey :white])

(def- units [[1e9 :gigaohms] [1e6 :megaohms] [1e3 :kiloohms] [1 :ohms]])

(defn resistance
  "(resistance colors) -> the resistance the first three color bands encode, as a label"
  [[a b c]]
  (def code |(index-of $ bands))
  (def ohms (* (+ (* 10 (code a)) (code b)) (math/pow 10 (code c))))
  (def [size unit] (or (find |(>= ohms (first $)) units) (last units)))
  {:value (/ ohms size) :unit unit})
