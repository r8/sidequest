t ← •Import "../lib/test.bqn"
g ← •Import "../proverb.bqn"

threePieces ← ⟨
  "For want of a nail the shoe was lost."
  "For want of a shoe the horse was lost."
  "And all for the want of a nail."
⟩

fullProverb ← ⟨
  "For want of a nail the shoe was lost."
  "For want of a shoe the horse was lost."
  "For want of a horse the rider was lost."
  "For want of a rider the message was lost."
  "For want of a message the battle was lost."
  "For want of a battle the kingdom was lost."
  "And all for the want of a nail."
⟩

fourPiecesModernized ← ⟨
  "For want of a pin the gun was lost."
  "For want of a gun the soldier was lost."
  "For want of a soldier the battle was lost."
  "And all for the want of a pin."
⟩

t.Run ⟨
  "zero pieces"‿{𝕊: ⟨⟩ t.Expect g.Recite ⟨⟩}
  "one piece"‿{𝕊: ⟨"And all for the want of a nail."⟩ t.Expect g.Recite ⟨"nail"⟩}
  "two pieces"‿{𝕊: ⟨"For want of a nail the shoe was lost.", "And all for the want of a nail."⟩ t.Expect g.Recite ⟨"nail", "shoe"⟩}
  "three pieces"‿{𝕊: threePieces t.Expect g.Recite ⟨"nail", "shoe", "horse"⟩}
  "full proverb"‿{𝕊: fullProverb t.Expect g.Recite ⟨"nail", "shoe", "horse", "rider", "message", "battle", "kingdom"⟩}
  "four pieces modernized"‿{𝕊: fourPiecesModernized t.Expect g.Recite ⟨"pin", "gun", "soldier", "battle"⟩}
⟩
