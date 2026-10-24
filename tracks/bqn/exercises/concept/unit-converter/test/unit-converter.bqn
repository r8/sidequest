t ← •Import "../lib/test.bqn"
g ← •Import "../unit-converter.bqn"

t.Run ⟨
  "1. boiling point"‿{𝕊: 212 t.Approx g.ToFahrenheit 100}
  "1. freezing point"‿{𝕊: 32 t.Approx g.ToFahrenheit 0}
  "1. a warm afternoon"‿{𝕊: 86 t.Approx g.ToFahrenheit 30}
  "1. where the scales meet"‿{𝕊: ¯40 t.Approx g.ToFahrenheit ¯40}
  "2. boiling point"‿{𝕊: 100 t.Approx g.ToCelsius 212}
  "2. freezing point"‿{𝕊: 0 t.Approx g.ToCelsius 32}
  "2. body temperature"‿{𝕊: 37 t.Approx g.ToCelsius 98.6}
  "2. below freezing"‿{𝕊: ¯10 t.Approx g.ToCelsius 14}
  "3. two rides"‿{𝕊: 80 t.Approx 30 g.TotalKm 20}
  "3. a rest day and a ride"‿{𝕊: 16 t.Approx 0 g.TotalKm 10}
  "3. two long rides"‿{𝕊: 200 t.Approx 62.5 g.TotalKm 62.5}
  "4. room to spare"‿{𝕊: 5 t.Expect 18 g.SpareKg 23}
  "4. exactly at the limit"‿{𝕊: 0 t.Expect 23 g.SpareKg 23}
  "4. too heavy"‿{𝕊: ¯2 t.Expect 25 g.SpareKg 23}
  "5. a ten-foot room"‿{𝕊: 9 t.Approx g.SquareMetres 10}
  "5. a twenty-foot suite"‿{𝕊: 36 t.Approx g.SquareMetres 20}
  "5. a broom cupboard"‿{𝕊: 1.44 t.Approx g.SquareMetres 4}
⟩
