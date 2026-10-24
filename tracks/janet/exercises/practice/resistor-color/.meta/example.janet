# A color is a keyword: :black :brown :red :orange :yellow :green :blue :violet :grey :white

(def- bands [:black :brown :red :orange :yellow :green :blue :violet :grey :white])

(defn color-code
  "(color-code color) -> the value of the color band, 0 to 9"
  [color]
  (index-of color bands))

(defn colors
  "(colors) -> the band colors in order of their value"
  []
  bands)
