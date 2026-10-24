t ← •Import "../lib/test.bqn"
g ← •Import "../pizza-night.bqn"

t.Run ⟨
  "1. fresh dough needs the full rise"‿{𝕊: 90 t.Expect g.RiseTimeLeft 0}
  "1. dough that has risen for a while"‿{𝕊: 65 t.Expect g.RiseTimeLeft 25}
  "1. dough that has finished rising"‿{𝕊: 0 t.Expect g.RiseTimeLeft 90}
  "2. one pizza"‿{𝕊: 27 t.Expect g.BakingTime 1}
  "2. three pizzas"‿{𝕊: 51 t.Expect g.BakingTime 3}
  "2. no pizzas still heats the oven"‿{𝕊: 15 t.Expect g.BakingTime 0}
  "3. one pizza and a spare"‿{𝕊: 500 t.Expect g.DoughNeeded 1}
  "3. four pizzas and a spare"‿{𝕊: 1250 t.Expect g.DoughNeeded 4}
  "3. ten pizzas and a spare"‿{𝕊: 2750 t.Expect g.DoughNeeded 10}
  "4. three pizzas, dough risen 25 minutes"‿{𝕊: 116 t.Expect 3 g.TotalTime 25}
  "4. one pizza, fresh dough"‿{𝕊: 117 t.Expect 1 g.TotalTime 0}
  "4. five pizzas, dough ready"‿{𝕊: 75 t.Expect 5 g.TotalTime 90}
  "5. six guests, three pizzas"‿{𝕊: 4 t.Expect 6 g.SlicesEach 3}
  "5. four guests, one pizza"‿{𝕊: 2 t.Expect 4 g.SlicesEach 1}
  "5. sixteen guests, one pizza"‿{𝕊: 0.5 t.Expect 16 g.SlicesEach 1}
⟩
