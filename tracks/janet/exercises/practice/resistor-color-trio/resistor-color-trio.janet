# A color is a keyword: :black :brown :red :orange :yellow :green :blue :violet :grey :white
# A label is a struct {:value 2 :unit :kiloohms}; the unit is one of :ohms :kiloohms
# :megaohms :gigaohms.
# `label` is a core Janet macro, so the function is called `resistance`.

(defn resistance
  "(resistance colors) -> the resistance the first three color bands encode, as a label"
  [colors]
  (error "implement me"))
