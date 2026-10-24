t ← •Import "../lib/test.bqn"
g ← •Import "../high-scores.bqn"

t.Run ⟨
  "List of scores"‿{𝕊: 30‿50‿20‿70 t.Expect g.Scores 30‿50‿20‿70}
  "Latest score"‿{𝕊: 30 t.Expect g.Latest 100‿0‿90‿30}
  "Personal best"‿{𝕊: 100 t.Expect g.PersonalBest 40‿100‿70}
  "Top 3 scores > Personal top three from a list of scores"‿{𝕊: 100‿90‿70 t.Expect g.PersonalTopThree 10‿30‿90‿30‿100‿20‿10‿0‿30‿40‿40‿70‿70}
  "Top 3 scores > Personal top highest to lowest"‿{𝕊: 30‿20‿10 t.Expect g.PersonalTopThree 20‿10‿30}
  "Top 3 scores > Personal top when there is a tie"‿{𝕊: 40‿40‿30 t.Expect g.PersonalTopThree 40‿20‿40‿30}
  "Top 3 scores > Personal top when there are less than 3"‿{𝕊: 70‿30 t.Expect g.PersonalTopThree 30‿70}
  "Top 3 scores > Personal top when there is only one"‿{𝕊: ⟨40⟩ t.Expect g.PersonalTopThree ⟨40⟩}
  "Top 3 scores > Latest score after personal top scores"‿{𝕊: s ← 70‿50‿20‿30 ⋄ g.PersonalTopThree s ⋄ 30 t.Expect g.Latest s}
  "Top 3 scores > Scores after personal top scores"‿{𝕊: s ← 30‿50‿20‿70 ⋄ g.PersonalTopThree s ⋄ 30‿50‿20‿70 t.Expect g.Scores s}
  "Top 3 scores > Latest score after personal best"‿{𝕊: s ← 20‿70‿15‿25‿30 ⋄ g.PersonalBest s ⋄ 30 t.Expect g.Latest s}
  "Top 3 scores > Scores after personal best"‿{𝕊: s ← 20‿70‿15‿25‿30 ⋄ g.PersonalBest s ⋄ 20‿70‿15‿25‿30 t.Expect g.Scores s}
⟩
