t ← •Import "../lib/test.bqn"
g ← •Import "../step-counter.bqn"

t.Run ⟨
  "1. three days"‿{𝕊: 3000‿6000‿4500 t.Expect 0.75 g.Distance 4000‿8000‿6000}
  "1. a longer stride"‿{𝕊: 1000‿0‿2500 t.Expect 0.5 g.Distance 2000‿0‿5000}
  "1. a single day"‿{𝕊: ⟨750⟩ t.Expect 0.75 g.Distance ⟨1000⟩}
  "1. no days yet"‿{𝕊: ⟨⟩ t.Expect 0.75 g.Distance ⟨⟩}
  "2. some days met the goal"‿{𝕊: 1‿0‿1 t.Expect 10000 g.GoalMet 12000‿8000‿10000}
  "2. a lazy week"‿{𝕊: 0‿0‿0‿0 t.Expect 10000 g.GoalMet 900‿2000‿4000‿9999}
  "2. an easy goal"‿{𝕊: 1‿1 t.Expect 0 g.GoalMet 0‿5}
  "3. four days"‿{𝕊: 4 t.Expect g.DaysRecorded 3000‿4000‿5000‿6000}
  "3. one day"‿{𝕊: 1 t.Expect g.DaysRecorded ⟨7000⟩}
  "3. no days"‿{𝕊: 0 t.Expect g.DaysRecorded ⟨⟩}
  "4. a third day"‿{𝕊: 4000‿5000‿6000 t.Expect 4000‿5000 g.AddDay 6000}
  "4. the first day"‿{𝕊: ⟨8000⟩ t.Expect ⟨⟩ g.AddDay 8000}
  "4. a day without steps"‿{𝕊: 1‿2‿0 t.Expect 1‿2 g.AddDay 0}
  "5. better, worse and the same"‿{𝕊: 500‿¯1000‿0 t.Expect 5000‿6000‿7000 g.Change 5500‿5000‿7000}
  "5. a whole week better"‿{𝕊: 1‿1‿1‿1‿1‿1‿1 t.Expect 1‿2‿3‿4‿5‿6‿7 g.Change 2‿3‿4‿5‿6‿7‿8}
  "5. no days to compare"‿{𝕊: ⟨⟩ t.Expect ⟨⟩ g.Change ⟨⟩}
  "6. three days"‿{𝕊: 1‿2‿3 t.Expect g.DayNumbers 300‿200‿500}
  "6. one day"‿{𝕊: ⟨1⟩ t.Expect g.DayNumbers ⟨12345⟩}
  "6. no days"‿{𝕊: ⟨⟩ t.Expect g.DayNumbers ⟨⟩}
⟩
