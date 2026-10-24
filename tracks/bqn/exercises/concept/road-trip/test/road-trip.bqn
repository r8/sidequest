t ← •Import "../lib/test.bqn"
g ← •Import "../road-trip.bqn"

t.Run ⟨
  "1. a 250 km leg"‿{𝕊: 15 t.Approx g.FuelNeeded 250}
  "1. a 100 km leg"‿{𝕊: 6 t.Approx g.FuelNeeded 100}
  "1. a short hop"‿{𝕊: 0.3 t.Approx g.FuelNeeded 5}
  "1. not moving"‿{𝕊: 0 t.Approx g.FuelNeeded 0}
  "2. a long leg"‿{𝕊: 2 t.Expect 500 g.Stops 1200}
  "2. exactly two tankfuls"‿{𝕊: 1 t.Expect 500 g.Stops 1000}
  "2. a leg within one tank"‿{𝕊: 0 t.Expect 500 g.Stops 320}
  "2. no leg at all"‿{𝕊: 0 t.Expect 500 g.Stops 0}
  "2. just over one tank"‿{𝕊: 1 t.Expect 450 g.Stops 451}
  "3. arriving the same day"‿{𝕊: 14 t.Expect 9 g.ArrivalTime 5}
  "3. arriving after midnight"‿{𝕊: 3 t.Expect 22 g.ArrivalTime 5}
  "3. arriving at midnight"‿{𝕊: 0 t.Expect 20 g.ArrivalTime 4}
  "3. driving for two days"‿{𝕊: 10 t.Expect 8 g.ArrivalTime 50}
  "4. some money left over"‿{𝕊: 3 t.Expect 10 g.Snacks 3}
  "4. exactly enough"‿{𝕊: 4 t.Expect 10 g.Snacks 2.5}
  "4. not enough for one"‿{𝕊: 0 t.Expect 2 g.Snacks 3}
  "5. east and north"‿{𝕊: 5 t.Approx 3 g.Distance 4}
  "5. west and south"‿{𝕊: 13 t.Approx ¯5 g.Distance ¯12}
  "5. due north"‿{𝕊: 7 t.Approx 0 g.Distance 7}
  "5. at home"‿{𝕊: 0 t.Approx 0 g.Distance 0}
⟩
