# planet Age seconds → the age in years on planet ("Mercury" … "Neptune"); errors with "not a planet"
# for any other name
planets ← "Mercury"‿"Venus"‿"Earth"‿"Mars"‿"Jupiter"‿"Saturn"‿"Uranus"‿"Neptune"
periods ← 0.2408467‿0.61519726‿1‿1.8808158‿11.862615‿29.447498‿84.016846‿164.79132  # Earth years

Age ⇐ {
  "not a planet" ! (≠planets) > i ← ⊑planets ⊐ <𝕨
  𝕩 ÷ 31557600 × i ⊑ periods
}
