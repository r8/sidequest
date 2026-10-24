# A color is a keyword: :black :brown :red :orange :yellow :green :blue :violet :grey :white

(def- bands [:black :brown :red :orange :yellow :green :blue :violet :grey :white])

(defn value
  "(value colors) -> the two-digit number the first two color bands encode"
  [[first-band second-band]]
  (+ (* 10 (index-of first-band bands)) (index-of second-band bands)))
