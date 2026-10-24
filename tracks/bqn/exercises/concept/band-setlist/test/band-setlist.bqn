t ← •Import "../lib/test.bqn"
g ← •Import "../band-setlist.bqn"

t.Run ⟨
  "1. three titles"‿{𝕊: 5‿10‿4 t.Expect g.TitleLengths "Intro"‿"Lights Out"‿"Home"}
  "1. one title"‿{𝕊: ⟨6⟩ t.Expect g.TitleLengths ⟨"Encore"⟩}
  "1. a one-letter title"‿{𝕊: 1‿3 t.Expect g.TitleLengths "X"‿"Why"}
  "1. no songs"‿{𝕊: ⟨⟩ t.Expect g.TitleLengths ⟨⟩}
  "2. two songs"‿{𝕊: "Next up: Intro!"‿"Next up: Home!" t.Expect g.Announce "Intro"‿"Home"}
  "2. one song"‿{𝕊: ⟨"Next up: Lights Out!"⟩ t.Expect g.Announce ⟨"Lights Out"⟩}
  "2. three songs"‿{𝕊: "Next up: A!"‿"Next up: Bb!"‿"Next up: Ccc!" t.Expect g.Announce "A"‿"Bb"‿"Ccc"}
  "3. two songs and writers"‿{𝕊: "Intro by Ana"‿"Home by Cy" t.Expect "Intro"‿"Home" g.Credit "Ana"‿"Cy"}
  "3. one song"‿{𝕊: ⟨"Encore by Bo"⟩ t.Expect ⟨"Encore"⟩ g.Credit ⟨"Bo"⟩}
  "3. the same writer twice"‿{𝕊: "A by Mo"‿"B by Mo"‿"C by Jo" t.Expect "A"‿"B"‿"C" g.Credit "Mo"‿"Mo"‿"Jo"}
  "4. two sets"‿{𝕊: ⟨2‿4, ⟨5⟩⟩ t.Expect g.ToMinutes ⟨120‿240, ⟨300⟩⟩}
  "4. half minutes"‿{𝕊: ⟨⟨3.5, 0.5⟩⟩ t.Expect g.ToMinutes ⟨210‿30⟩}
  "4. an empty set"‿{𝕊: ⟨⟨1⟩, ⟨⟩⟩ t.Expect g.ToMinutes ⟨⟨60⟩, ⟨⟩⟩}
  "5. two setlists"‿{𝕊: ⟨5‿4, ⟨6⟩⟩ t.Expect g.TourTitleLengths ⟨"Intro"‿"Home", ⟨"Encore"⟩⟩}
  "5. three setlists"‿{𝕊: ⟨⟨1⟩, 2‿3, 4‿5‿6⟩ t.Expect g.TourTitleLengths ⟨⟨"a"⟩, "ab"‿"abc", "abcd"‿"abcde"‿"abcdef"⟩}
⟩
