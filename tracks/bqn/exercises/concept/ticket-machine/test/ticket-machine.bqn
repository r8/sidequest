t ← •Import "../lib/test.bqn"
g ← •Import "../ticket-machine.bqn"

t.Run ⟨
  "1. two adults and a child over two zones"‿{𝕊: 12.5 t.Approx 2 g.Fare 2‿1}
  "1. one adult in the harbour zone"‿{𝕊: 2 t.Approx 0 g.Fare 1‿0}
  "1. children only"‿{𝕊: 8 t.Approx 4 g.Fare 0‿2}
  "1. nobody"‿{𝕊: 0 t.Approx 3 g.Fare 0‿0}
  "2. twos and a one"‿{𝕊: 2‿1 t.Expect 10 g.MakeChange 5}
  "2. twos only"‿{𝕊: 3‿0 t.Expect 20 g.MakeChange 14}
  "2. a single one"‿{𝕊: 0‿1 t.Expect 4 g.MakeChange 3}
  "2. exact money"‿{𝕊: 0‿0 t.Expect 7 g.MakeChange 7}
  "3. in the middle of the ticket's time"‿{𝕊: 1 t.Expect 600‿90 g.Valid 650}
  "3. the first valid minute"‿{𝕊: 1 t.Expect 600‿90 g.Valid 600}
  "3. just expired"‿{𝕊: 0 t.Expect 600‿90 g.Valid 690}
  "3. not valid yet"‿{𝕊: 0 t.Expect 600‿90 g.Valid 599}
  "4. four departures"‿{𝕊: 600‿645‿690‿735 t.Expect 600‿45 g.Departures 4}
  "4. one departure"‿{𝕊: ⟨480⟩ t.Expect 480‿30 g.Departures 1}
  "4. none"‿{𝕊: ⟨⟩ t.Expect 480‿30 g.Departures 0}
  "5. no discounts"‿{𝕊: 3 t.Approx g.Discounted 3‿0‿0}
  "5. a senior"‿{𝕊: 3 t.Approx g.Discounted 6‿1‿0}
  "5. a member"‿{𝕊: 5 t.Approx g.Discounted 6‿0‿1}
  "5. a senior member"‿{𝕊: 2 t.Approx g.Discounted 6‿1‿1}
  "5. never below half a coin"‿{𝕊: 0.5 t.Approx g.Discounted 1‿1‿1}
⟩
