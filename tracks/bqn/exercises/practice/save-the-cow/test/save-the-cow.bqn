t ← •Import "../lib/test.bqn"
g ← •Import "../save-the-cow.bqn"

t.Run ⟨
  "Initially 9 failures are allowed and no letters are guessed"‿{𝕊: "Ongoing"‿"____"‿9 t.Expect "loot" g.Guess ""}
  "After 10 failures the game is over"‿{𝕊: "Lose"‿"____"‿0 t.Expect "loot" g.Guess "abcdefghij"}
  "Losing with several correct guesses"‿{𝕊: "Lose"‿"_oot"‿0 t.Expect "loot" g.Guess "toabcdefghij"}
  "Feeding a correct letter removes underscores"‿{𝕊: "Ongoing"‿"___t"‿9 t.Expect "loot" g.Guess "t"}
  "Feeding a correct letter twice counts as a failure"‿{𝕊: "Ongoing"‿"___t"‿8 t.Expect "loot" g.Guess "tt"}
  "Guessing a repeated letter reveals all instances"‿{𝕊: "Ongoing"‿"_oot"‿8 t.Expect "loot" g.Guess "tto"}
  "Getting all the letters right makes for a win"‿{𝕊: "Win"‿"loot"‿8 t.Expect "loot" g.Guess "ttol"}
  "Winning on the last guess is still a win"‿{𝕊: "Win"‿"loot"‿0 t.Expect "loot" g.Guess "abcdefghitol"}
  "Guessing after a lose is error"‿{𝕊: {𝕊: "loot" g.Guess "abcdefghijk"} t._throws "cannot guess after the game is lost"}
  "Guessing after a win is error"‿{𝕊: {𝕊: "loot" g.Guess "toll"} t._throws "cannot guess after the game is won"}
⟩
