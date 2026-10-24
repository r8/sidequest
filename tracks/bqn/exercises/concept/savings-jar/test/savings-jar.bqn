t ← •Import "../lib/test.bqn"
g ← •Import "../savings-jar.bqn"

t.Run ⟨
  "1. four weeks"‿{𝕊: 5‿3‿13‿9 t.Expect g.Balances 5‿¯2‿10‿¯4}
  "1. one week"‿{𝕊: ⟨7⟩ t.Expect g.Balances ⟨7⟩}
  "1. going below zero"‿{𝕊: ¯3‿¯1‿¯1 t.Expect g.Balances ¯3‿2‿0}
  "1. no weeks yet"‿{𝕊: ⟨⟩ t.Expect g.Balances ⟨⟩}
  "2. birthday money"‿{𝕊: 25‿23‿33 t.Expect 20 g.BalancesFrom 5‿¯2‿10}
  "2. spending it all"‿{𝕊: 5‿0 t.Expect 10 g.BalancesFrom ¯5‿¯5}
  "2. starting from nothing"‿{𝕊: 5‿3 t.Expect 0 g.BalancesFrom 5‿¯2}
  "2. no weeks yet"‿{𝕊: ⟨⟩ t.Expect 20 g.BalancesFrom ⟨⟩}
  "3. records"‿{𝕊: 5‿5‿13‿13 t.Expect g.Records 5‿3‿13‿9}
  "3. always growing"‿{𝕊: 1‿2‿3 t.Expect g.Records 1‿2‿3}
  "3. negative balances"‿{𝕊: ¯4‿¯1‿¯1 t.Expect g.Records ¯4‿¯1‿¯3}
  "4. debt in the third week"‿{𝕊: 1‿1‿0‿0 t.Expect g.NeverInDebt 5‿0‿¯2‿4}
  "4. never in debt"‿{𝕊: 1‿1‿1 t.Expect g.NeverInDebt 3‿0‿8}
  "4. in debt from the start"‿{𝕊: 0‿0 t.Expect g.NeverInDebt ¯1‿5}
  "5. reached in the second week"‿{𝕊: 0‿1‿1‿1 t.Expect 10 g.GoalReached 5‿6‿¯4‿3}
  "5. reached exactly"‿{𝕊: 0‿0‿1 t.Expect 6 g.GoalReached 2‿2‿2}
  "5. not reached yet"‿{𝕊: 0‿0‿0 t.Expect 100 g.GoalReached 10‿20‿30}
  "5. reached in the first week"‿{𝕊: 1‿1 t.Expect 5 g.GoalReached 9‿¯9}
⟩
