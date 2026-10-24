# Planets are keywords: :mercury, :venus, :earth, :mars, :jupiter, :saturn, :uranus, :neptune.

(def- earth-year-seconds 31557600)

# Orbital periods in Earth years.
(def- orbital-periods
  {:mercury 0.2408467 :venus 0.61519726 :earth 1.0 :mars 1.8808158
   :jupiter 11.862615 :saturn 29.447498 :uranus 84.016846 :neptune 164.79132})

(defn age
  "(age planet seconds) -> the age in planet years of someone seconds old; errors for an unknown planet"
  [planet seconds]
  (def period (or (orbital-periods planet) (error "not a planet")))
  (/ seconds earth-year-seconds period))
