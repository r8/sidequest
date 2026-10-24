t ← •Import "../lib/test.bqn"
g ← •Import "../race-results.bqn"

names ← "Ana"‿"Ben"‿"Cy"‿"Dee"

t.Run ⟨
  "1. times out of order"‿{𝕊: 27‿27‿31‿35 t.Expect g.SortedTimes 31‿27‿35‿27}
  "1. times already in order"‿{𝕊: 20‿21‿22 t.Expect g.SortedTimes 20‿21‿22}
  "1. fractions of a minute"‿{𝕊: 28.5‿29‿29.25 t.Expect g.SortedTimes 29.25‿28.5‿29}
  "1. nobody finished"‿{𝕊: ⟨⟩ t.Expect g.SortedTimes ⟨⟩}
  "2. names out of order"‿{𝕊: names t.Expect g.Alphabetical "Cy"‿"Ana"‿"Dee"‿"Ben"}
  "2. a name that starts another"‿{𝕊: "Al"‿"Alma"‿"Bo" t.Expect g.Alphabetical "Alma"‿"Bo"‿"Al"}
  "2. one runner"‿{𝕊: ⟨"Ana"⟩ t.Expect g.Alphabetical ⟨"Ana"⟩}
  "3. two runners with the same time"‿{𝕊: "Ben"‿"Dee"‿"Ana"‿"Cy" t.Expect names g.Finishers 31‿27‿35‿27}
  "3. listed slowest first"‿{𝕊: "Dee"‿"Cy"‿"Ben"‿"Ana" t.Expect names g.Finishers 40‿35‿30‿25}
  "3. already in order"‿{𝕊: names t.Expect names g.Finishers 25‿30‿30‿41}
  "4. a clear winner"‿{𝕊: "Cy" t.Expect names g.Winner 31‿27‿22‿27}
  "4. a tie for first goes to the runner listed first"‿{𝕊: "Ben" t.Expect names g.Winner 31‿27‿35‿27}
  "4. the last runner wins"‿{𝕊: "Dee" t.Expect names g.Winner 40‿35‿30‿25}
  "5. places with a tie"‿{𝕊: 3‿1‿4‿2 t.Expect g.Places 31‿27‿35‿27}
  "5. listed slowest first"‿{𝕊: 4‿3‿2‿1 t.Expect g.Places 40‿35‿30‿25}
  "5. a single runner wins"‿{𝕊: ⟨1⟩ t.Expect g.Places ⟨33⟩}
  "5. places are not the sorted order"‿{𝕊: 2‿5‿1‿3‿4 t.Expect g.Places 21‿50‿20‿30‿44}
  "6. most points first, ties in listed order"‿{𝕊: "Ben"‿"Cy"‿"Ana"‿"Dee" t.Expect names g.Leaderboard 3‿5‿5‿1}
  "6. everyone tied"‿{𝕊: names t.Expect names g.Leaderboard 2‿2‿2‿2}
  "6. fewest points listed first"‿{𝕊: "Dee"‿"Cy"‿"Ben"‿"Ana" t.Expect names g.Leaderboard 1‿2‿3‿4}
⟩
